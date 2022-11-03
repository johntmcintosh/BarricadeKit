//
//  ErrorResponse.swift
//  Barricade
//
//  Created by John McIntosh on 5/8/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


public protocol ErrorResponse {
    
    /// The name represents the string name used to identify this request in the context of your app.
    /// It is for the developer's use only.
    var name: String { get }
    
    var error: Error? { get }

    /**
     Barricade will call this method on an ErrorResponse object and will use its return value for populating
     the Error response that is returned from the barricade. Simple implementations of this protocol
     can implement this method to just return a copy of the existing request.
     
     More advanced implementations of the protocol could implement this function as a hook to inject dynamic
     data into the response object before returning it to the called. For example, this could be used to
     set the source URL of an error payload..
     */
    func error(for: URLRequest) -> Error
}
