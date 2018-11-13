//
//  Errors.swift
//  Barricade
//
//  Created by John McIntosh on 5/8/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


public enum BarricadeError: Error, Equatable {
    case noResponseRegistered(URLRequest)
    case unableToGenerateUrlResponse
    case emptyFilePath
    case responseFileNotFound
    case malformedJson
    case unknown
}


extension BarricadeError {
    
    var localizedDescription: String {
        switch self {
        case .noResponseRegistered(let request):
            return "Barricade attempted to return a response, but no response has been registered that is capable of responding to the request to the URL: \(request.url?.absoluteString ?? "")"
        case .unableToGenerateUrlResponse:
            return "Unable to generate a HTTPURLResponse for the request."
        case .emptyFilePath:
            return "An empty file path was used to generate this response. Double-check that you are using a valid file path."
        case .responseFileNotFound:
            return "No file could be found at the provided location."
        case .malformedJson:
            return "There was an attempt to generate a response with a malformed JSON object. Double-check that your object is valid JSON."
        case .unknown:
            return "An unknown error has occurred."
        }
    }
}
