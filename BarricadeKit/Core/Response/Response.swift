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
