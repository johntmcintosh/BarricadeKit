//
//  ResponseSet.swift
//  Barricade
//
//  Created by John McIntosh on 5/5/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


public struct ResponseSet {
        
    public var requestName: String
    
    public private(set) var allResponses: [Response]
    
    private var evaluation: ResponseSetEvaluation

    public init(requestName: String, evaluation: ResponseSetEvaluation) {
        self.requestName = requestName
        self.allResponses = []
        self.evaluation = evaluation
    }
    
    public mutating func add(response: NetworkResponse) {
        allResponses.append(.network(response))
    }

    public mutating func add(response: ErrorResponse) {
        allResponses.append(.error(response))
    }

    public func response(named: String) -> Response? {
        return allResponses.first(where: { response -> Bool in
            switch response {
            case .network(let network):
                return network.name == named
            case .error(let error):
                return error.name == named
            }
        })
    }
    
    public func responds(to request: URLRequest, components: URLComponents) -> Bool {
        return evaluation.evaluate(request: request, components: components)
    }
    
    public var defaultResponse: Response? {
        return allResponses.first
    }
}


extension ResponseSet {
    
    public func createResponse(responseGenerator: ()->(Response)) {
        // TODO: Implement
    }
    
    public func createResponse(name: String, hook: (Response) -> ()) {
        // TODO: Implement
    }
    
    public func add(named: String, file: String, statusCode: Int, contentType: String) -> NetworkResponse {
        // TODO: Implement
        return MockResponse()
    }
    
    public func addJSON(named: String, file: String, statusCode: Int = 200) -> NetworkResponse {
        // TODO: Implement
        return MockResponse()
    }
    
    public func addFailure() {
        // TODO: Implement application-specific failure
    }
}


private struct MockResponse: NetworkResponse {
    
    var name: String = "Mock"
    var statusCode: Int = 200
    var content: Data? = nil
    var allHeaderFields: [String : String] = [:]
    var error: Error? = nil
    func modifiedResponse(for: URLRequest) -> NetworkResponse {
        return self
    }
}
