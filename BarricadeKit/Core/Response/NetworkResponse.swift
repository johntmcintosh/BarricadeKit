//
//  NetworkResponse.swift
//  Barricade
//
//  Created by John McIntosh on 5/5/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


/**
 A concrete implementation of `Response` represents a single response that can be returned
 from the barricade, and should be thought of as a replication of what your server might return as
 the response to an API request.
 
 This protocol makes no assumptions about where the content of the response comes from. Feel free to
 create additional concrete implementations of this protocol for your own needs.
 */
public protocol NetworkResponse {
    
    /// The name represents the string name used to identify this request in the context of your app.
    /// It is for the developer's use only.
    var name: String { get }
    
    /// The HTTP status code associated with the response. For exapmle, 200 typically represents a standard,
    /// successful response.
    var statusCode: Int { get }
    
    /// Raw representation of the response body.
    var content: Data? { get }
    
    /// A dictionary containing all the HTTP header fields in the response.
    var allHeaderFields: [String: String] { get }
    
    /**
     Barricade will call this method on a NetworkResponse object and will use its return value for populating
     the network response that is returned from the barricade. Simple implementations of this protocol
     can implement this method to just return a copy of the existing request.
     
     More advanced implementations of the protocol could implement this method as a hook to inject dynamic
     data into the response object before returning it to the called. For example, this could be used to
     set the `date` field of a JSON property in the response so that it is always today's date, whereas
     if the response is simply returning a static JSON  file, the date would not dynamically change.
     */
    func modifiedResponse(for: URLRequest) -> NetworkResponse
}


extension NetworkResponse {
    
    func urlResponse(for request: URLRequest) -> URLResponse? {
        guard let url = request.url else { return nil }
        return HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: allHeaderFields)
    }
}
