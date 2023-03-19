//
//  XMLElement.swift
//  
//
//  Created by Stefan Klein Nulent on 18/03/2023.
//

import Foundation

public struct XMLElement {

    // MARK: - Properties
    
    public var name: TagName
    public var children: [XMLNode] = []
    public var attributes: [AttributeName: String] = [:]
    
    public var childElements: [XMLElement] {
        children.compactMap{
            if case .element(let element) = $0 {
                return element
            } else {
                return nil
            }
        }
    }
    
    public var text: String {
        var text = ""
        for node in children {
            switch node {
            case .text(let string):
                text += string
            case .element(let element):
                text += element.text
            }
        }
        return text
    }
    
    
    
    // MARK: - Construction
    
    public init(_ name: TagName, children: [XMLNode] = [], attributes: [AttributeName: String] = [:]) {
        self.name = name
        self.children = children
        self.attributes = attributes
    }
    
    public init(_ name: TagName, childElements: [XMLElement], attributes: [AttributeName: String] = [:]) {
        self.init(name, children: childElements.map{ XMLNode.element($0) }, attributes: attributes)
    }
    
    public init(_ name: TagName, child: XMLNode, attributes: [AttributeName: String] = [:]) {
        self.init(name, children: [child], attributes: attributes)
    }
    
    public init(_ name: TagName, text: CustomStringConvertible, attributes: [AttributeName: String] = [:]) {
        self.init(name, child: .text(text.description), attributes: attributes)
    }
    
    public init(_ name: TagName, childElement: XMLElement, attributes: [AttributeName: String] = [:]) {
        self.init(name, childElements: [childElement], attributes: attributes)
    }

    
    
    // MARK: - Functions
    
    public func firstChild(by tagName: TagName) -> XMLElement? {
        if let child = childElements.filter({ $0.name == tagName }).first {
            return child
        } else {
            return childElements.compactMap{ $0.firstChild(by: tagName) }.first
        }
    }
    
    public func firstText(by tagName: TagName) -> String? {
        firstChild(by: tagName)?.text
    }
}
