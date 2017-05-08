//
//  Errors.swift
//  Barricade
//
//  Created by John McIntosh on 5/8/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


enum BarricadeError: Error {
    case noResponseRegistered(URLRequest)
    case unableToGenerateUrlResponse
    case unknown
}


extension BarricadeError {
    
    var localizedDescription: String {
        switch self {
        case .noResponseRegistered(let request):
            return "Barricade attempted to return a response, but no response has been registered that is capable of responding to the request to the URL: \(request.url?.absoluteString ?? "")"
        case .unableToGenerateUrlResponse:
            return "Unable to generate a HTTPURLResponse for the request."
        case .unknown:
            return "An unknown error has occurred."
        }
    }
}
