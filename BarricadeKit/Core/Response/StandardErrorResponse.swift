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
    public var error: Error
    
    public init(name: String, error: Error) {
        self.name = name
        self.error = error
    }
}
