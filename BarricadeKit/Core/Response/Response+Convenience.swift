//
//  Response+Convenience.swift
//  Barricade
//
//  Created by John McIntosh on 5/8/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


extension Response {

    public static func make(name: String, error: Error) -> Response {
        return .error(StandardErrorResponse(name: name, error: error))
    }

    public static func make(name: String, json: Any, statusCode: Int, contentType: String? = nil, headers: [String: String]? = nil) -> Response {
        guard JSONSerialization.isValidJSONObject(json) else {
            return make(name: name, error: BarricadeError.malformedJson)
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            return make(name: name, data: data, statusCode: statusCode, contentType: contentType, headers: headers)
        }
        catch {
            return make(name: name, error: error)
        }
    }
    
    public static func make(name: String, path: URL, statusCode: Int, contentType: String? = nil, headers: [String: String]? = nil) -> Response {
        do {
            let data = try Data(contentsOf: path)
            return make(name: name, data: data, statusCode: statusCode, contentType: contentType, headers: headers)
        }
        catch {
            return make(name: name, error: error)
        }
    }

    public static func make(name: String, data: Data, statusCode: Int, contentType: String? = nil, headers: [String: String]? = nil) -> Response {
        var response = StandardNetworkResponse(name: name, statusCode: statusCode, contentType: contentType)
        response.content = data
        if let headers = headers {
            response.customHeaderFields = headers
        }
        return .network(response)
    }
}
