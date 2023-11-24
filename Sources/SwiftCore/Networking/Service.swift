//
//  Service.swift
//  
//
//  Created by Stefan Klein Nulent on 11/12/2022.
//

import Foundation

open class Service {
    
    // MARK: - Types
    
    public typealias Parameters = [(name: String, value: CustomStringConvertible)]
    
    public enum ServiceError: Error {
        case failure(HTTPStatus, Data)
    }
    
    
    
    // MARK: - Properties
    
    open var baseURL: URL? { nil }
    open var configuration: URLSessionConfiguration { .default }
    
    
    
    // MARK: - Construction
    
    public init() {
        
    }
    
    
    
    // MARK: - Functions
    
    public func get<Response: Decodable>(_ path: String, parameters: Parameters? = nil) async throws -> Response {
        try await request(URLRequest(method: .get, url: url(for: path, parameters: parameters)), decode: decode)
    }
    
    public func get<Response: Decodable>(_ url: URL) async throws -> Response {
        try await request(URLRequest(method: .get, url: url), decode: decode)
    }
    
    public func get<Response>(_ url: URL, decode: @escaping (Data) throws -> Response) async throws -> Response {
        try await request(URLRequest(method: .get, url: url), decode: decode)
    }
    
    public func get<Response>(_ path: String, parameters: Parameters? = nil, decode: @escaping (Data) throws -> Response) async throws -> Response {
        try await request(URLRequest(method: .get, url: url(for: path, parameters: parameters)), decode: decode)
    }
    
    public func post<Body: Encodable, Response: Decodable>(_ path: String, parameters: Parameters? = nil, body: Body) async throws -> Response {
        try await request(URLRequest(method: .post, url: url(for: path, parameters: parameters)), body: body, encode: encode, decode: decode)
    }
    
    public func post<Response: Decodable>(_ path: String, parameters: Parameters? = nil) async throws -> Response {
        try await request(URLRequest(method: .post, url: url(for: path, parameters: parameters)), decode: decode)
    }
    
    public func post<Response: Decodable>(_ path: String, parameters: Parameters? = nil, body: MultipartFormData) async throws -> Response {
        try await request(URLRequest(method: .post, url: url(for: path, parameters: parameters)), body: body)
    }
    
    public func post<Response>(_ path: String, parameters: Parameters? = nil, decode: @escaping (Data) throws -> Response) async throws -> Response {
        try await request(URLRequest(method: .post, url: url(for: path, parameters: parameters)), decode: decode)
    }
    
    public func post(_ path: String, parameters: Parameters? = nil) async throws {
        try await request(URLRequest(method: .post, url: url(for: path, parameters: parameters)), decode: { _ in })
    }
    
    public func put<Body: Encodable, Response: Decodable>(_ path: String, parameters: Parameters? = nil, body: Body) async throws -> Response {
        try await request(URLRequest(method: .put, url: url(for: path, parameters: parameters)), body: body, encode: encode, decode: decode)
    }
    
    public func put<Response: Decodable>(_ path: String, parameters: Parameters? = nil) async throws -> Response {
        try await request(URLRequest(method: .put, url: url(for: path, parameters: parameters)), decode: decode)
    }
    
    public func patch<Body: Encodable, Response: Decodable>(_ path: String, parameters: Parameters? = nil, body: Body) async throws -> Response {
        try await request(URLRequest(method: .patch, url: url(for: path, parameters: parameters)), body: body, encode: encode, decode: decode)
    }
    
    public func delete(_ path: String, parameters: Parameters? = nil) async throws {
        try await request(URLRequest(method: .delete, url: url(for: path, parameters: parameters)), decode: { _ in })
    }
    
    public func request<Body: Encodable, Response: Decodable>(_ request: URLRequest, body: Body) async throws -> Response {
        try await self.request(request, body: body, encode: encode, decode: decode)
    }
    
    public func request<Response: Decodable>(_ request: URLRequest, body: MultipartFormData) async throws -> Response {
        try await self.request(request, body: body, encode: encode, decode: decode)
    }
    
    public func url(for path: String, parameters: Parameters? = nil) throws -> URL {
        if let url = URL(string: path, relativeTo: baseURL) {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            if let parameters = parameters {
                let queryItems = (components?.queryItems ?? []) + parameters.map { URLQueryItem(name: $0.name, value: $0.value.description) }
                components?.queryItems = queryItems
            }
            
            if let url = components?.url {
                return url
            } else {
                throw URLError(.badURL)
            }
        } else {
            throw URLError(.badURL)
        }
    }
    
    open func prepare(_ request: URLRequest) async throws -> URLRequest {
        var request = request
        request.cachePolicy = .reloadIgnoringLocalCacheData
        return request
    }
    
    open func validate(_ response: URLResponse, data: Data) throws {
        guard let response = response as? HTTPURLResponse else { return }
        
        if !response.status.isSuccess {
            throw ServiceError.failure(response.status, data)
        }
    }
    
    open func encode(_ body: MultipartFormData, request: URLRequest) throws -> URLRequest {
        var request = request
        request.setValue(body.httpContentTypeHeaderValue, forHTTPHeaderField: "Content-Type")
        request.httpBody = body.httpBody
        
        return request
    }
    
    open func encode<Body: Encodable>(_ body: Body, request: URLRequest) throws -> URLRequest {
        var request = request
        
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    open func decode<Response: Decodable>(_ data: Data) throws -> Response {
        try JSONDecoder().decode(Response.self, from: data)
    }
    
    
    
    // MARK: - Private Functions
    
    private func request<Body, Response>(_ request: URLRequest, body: Body, encode: (Body, URLRequest) throws -> URLRequest, decode: @escaping (Data) throws -> Response) async throws -> Response {
        try await self.request(try encode(body, request), decode: decode)
    }
    
    private func request<Response>(_ request: URLRequest, decode: @escaping (Data) throws -> Response) async throws -> Response {
        let request = try await prepare(request)
        let session = URLSession(configuration: configuration)
        
        let (data, response) = try await session.data(for: request)
        try validate(response, data: data)
        
        return try decode(data)
    }
}
