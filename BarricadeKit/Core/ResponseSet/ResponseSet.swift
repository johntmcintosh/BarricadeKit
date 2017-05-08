//
//  ResponseSet.swift
//  Barricade
//
//  Created by John McIntosh on 5/5/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


public struct ResponseSetEvaluation {
    
    public static func suffix(_ suffix: String) -> ResponseSetEvaluation {
        return ResponseSetEvaluation { _, components -> Bool in
            return components.path.hasSuffix(suffix)
        }
    }

    public static func closure(_ evaluation: @escaping Evaluation) -> ResponseSetEvaluation {
        return ResponseSetEvaluation { request, components -> Bool in
            return evaluation(request, components)
        }
    }

    public typealias Evaluation = (URLRequest, URLComponents) -> Bool
    private var internalClosure: Evaluation
    
    func evaluate(request: URLRequest, components: URLComponents) -> Bool {
        return internalClosure(request, components)
    }
}


public struct ResponseSet {
        
    public var requestName: String
    
    public private(set) var allResponses: [Response]
    
    public var evaluation: ResponseSetEvaluation

    public init(requestName: String, evaluation: ResponseSetEvaluation) {
        self.requestName = requestName
        self.allResponses = []
        self.evaluation = evaluation
    }
    
    public func add(response: Response) {
        // TODO: Implement
    }
    
    public func createResponse(responseGenerator: ()->(Response)) {
        // TODO: Implement
    }
    
    public func createResponse(name: String, hook: (Response) -> ()) {
        // TODO: Implement
    }
    
    public func response(named: String) -> Response? {
        // TODO: Implement
        return nil
    }
}


extension ResponseSet {
    
    public func add(named: String, file: String, statusCode: Int, contentType: String) -> Response {
        // TODO: Implement
        return MockResponse()
    }
    
    public func addJSON(named: String, file: String, statusCode: Int = 200) -> Response {
        // TODO: Implement
        return MockResponse()
    }
    
    public func addFailure() {
        // TODO: Implement application-specific failure
    }
}


private struct MockResponse: Response {
    
    var name: String = "Mock"
    var statusCode: Int = 200
    var content: Data? = nil
    var allHeaderFields: [String : String] = [:]
    var error: Error? = nil
    func modifiedResponse(for: URLRequest) -> Response {
        return self
    }
}
