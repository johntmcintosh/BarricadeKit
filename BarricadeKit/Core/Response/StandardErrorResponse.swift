//
//  StandardErrorResponse.swift
//  Barricade
//
//  Created by John McIntosh on 5/8/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


public struct StandardErrorResponse: ErrorResponse {
    
    public var name: String
    public var error: Error?
    
    private var errorGenerator: (URLRequest) -> Error
    
    public init(name: String, errorGenerator: @escaping (URLRequest) -> Error) {
        self.name = name
        self.errorGenerator = errorGenerator
    }

    public init(name: String, error: Error) {
        self.name = name
        self.error = error
        self.errorGenerator = { _ in error }
    }
    
    public func error(for request: URLRequest) -> Error {
        errorGenerator(request)
    }
}
