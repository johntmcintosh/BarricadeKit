//
//  StandardNetworkResponse.swift
//  Barricade
//
//  Created by John McIntosh on 5/8/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


public struct StandardNetworkResponse: NetworkResponse {

    // MARK: Response
    
    public var name: String
    public var statusCode: Int
    public var content: Data?
    public var allHeaderFields: [String : String] {
        get {
            var headers = customHeaderFields
            if let type = contentType {
                headers[Header.contentType] = type
            }
            return headers
        }
    }

    public func modifiedResponse(for: URLRequest) -> NetworkResponse {
        return self
    }
    

    // MARK: Custom
    
    public var customHeaderFields: [String : String] = [:]
    public var contentType: String?
    public var contentString: String? {
        get {
            guard let data = content else { return nil }
            return String(data: data, encoding: .utf8)
        }
        set {
            content = newValue?.data(using: .utf8)
        }
    }
    
    // MARK: Initializers
    
    public init(name: String, statusCode: Int, contentType: String? = nil) {
        self.name = name
        self.statusCode = statusCode
        self.contentType = contentType
    }
}
