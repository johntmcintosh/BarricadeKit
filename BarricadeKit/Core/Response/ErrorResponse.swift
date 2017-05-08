//
//  ErrorResponse.swift
//  Barricade
//
//  Created by John McIntosh on 5/8/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


public protocol ErrorResponse {
    
    var name: String { get }
    var error: Error { get }
}
