//
//  FileBasedResponseGenerator.swift
//  Barricade
//
//  Created by John McIntosh on 5/10/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


public struct FileBasedResponseGenerator {
    
    let contentType: String
    let directory: String
    
    public init(contentType: String, directory: String) {
        self.contentType = contentType
        self.directory = directory
    }
    
    public func response(named: String, file: String, statusCode: Int, headers: [String: String]? = nil) -> Response {
        guard let url = BarricadeKit.url(for: file, in: directory) else {
            return Response.make(name: named, error: BarricadeError.responseFileNotFound)
        }
        
        return Response.make(name: named, path: url, statusCode: statusCode, contentType: contentType, headers: headers)
    }
}
