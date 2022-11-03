//
//  Errors.swift
//  Barricade
//
//  Created by John McIntosh on 5/8/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


public enum BarricadeError: LocalizedError, CustomNSError, Equatable {
    case noResponseRegistered(URLRequest)   // code 0
    case unableToGenerateUrlResponse        // code 1
    case emptyFilePath                      // code 2
    case responseFileNotFound               // code 3
    case malformedJson                      // code 4
    case errorResponseMissingError          // code 5
    case unknown                            // code 6
}

public extension BarricadeError {
    var errorUserInfo: [String : Any] {
        var userInfo: [String: Any] = [:]
        if let errorDescription { userInfo[NSLocalizedDescriptionKey] = errorDescription }
        if let failureReason { userInfo[NSLocalizedFailureReasonErrorKey] = failureReason }
        if let recoverySuggestion { userInfo[NSLocalizedRecoverySuggestionErrorKey] = recoverySuggestion }
        return userInfo
    }
}

public extension BarricadeError {
    
    var errorDescription: String? {
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
        case .errorResponseMissingError:
            return "An error response was triggered, but no error value was present."
        case .unknown:
            return "An unknown error has occurred."
        }
    }
}
