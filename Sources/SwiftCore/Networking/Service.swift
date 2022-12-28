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
    
    
    
    // MARK: - Properties
    
    open var baseURL: URL? { nil }
    open var configuration: URLSessionConfiguration { .default }
    
    
    
    // MARK: - Construction
    
    public init() {
        
    }
    
    
    
    // MARK: - Functions
    
    public func get<Response: Decodable>(_ path: String, parameters: Parameters? = nil) async throws -> Response {
        try await request(URLRequest(method: .get, url: url(for: path, parameters: parameters)))
    }
    
    public func post<Body: Encodable, Response: Decodable>(_ path: String, parameters: Parameters? = nil, body: Body) async throws -> Response {
        try await request(URLRequest(method: .post, url: url(for: path, parameters: parameters)), body: body)
    }
    
    public func put<Body: Encodable, Response: Decodable>(_ path: String, parameters: Parameters? = nil, body: Body) async throws -> Response {
        try await request(URLRequest(method: .put, url: url(for: path, parameters: parameters)), body: body)
    }
    
    public func patch<Body: Encodable, Response: Decodable>(_ path: String, parameters: Parameters? = nil, body: Body) async throws -> Response {
        try await request(URLRequest(method: .patch, url: url(for: path, parameters: parameters)), body: body)
    }
    
    public func request<Body: Encodable, Response: Decodable>(_ request: URLRequest, body: Body) async throws -> Response {
        var request = request
        request.httpBody = try JSONEncoder().encode(body)
        
        return try await self.request(request)
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
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
    
    
    
    // MARK: - Private Functions
    
    private func request<Response: Decodable>(_ request: URLRequest) async throws -> Response {
        let request = try await prepare(request)
        let session = URLSession(configuration: configuration)
        
        let (data, _) = try await session.data(for: request)
        
        return try JSONDecoder().decode(Response.self, from: data)
    }
}
