//
//  Response.swift
//  Barricade
//
//  Created by John McIntosh on 5/8/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


public enum Response {
    case network(NetworkResponse)
    case error(ErrorResponse)
}


extension Response {
    
    public var name: String {
        switch self {
        case .network(let response):
            return response.name
        case .error(let response):
            return response.name
        }
    }
}

extension Response {
    
    func modified(for request: URLRequest) -> Response {
        switch self {
        case .network(let networkResponse):
            return networkResponse.modifiedResponse(for: request)
        case .error(let errorResponse):
            let modifiedError = errorResponse.error(for: request)
            return .error(StandardErrorResponse(name: errorResponse.name, error: modifiedError))
        }
    }
}
