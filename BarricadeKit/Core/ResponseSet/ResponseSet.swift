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

    public mutating func add(response: Response) {
        allResponses.append(response)
    }

    public mutating func add(response: NetworkResponse) {
        allResponses.append(.network(response))
    }

    public mutating func add(response: ErrorResponse) {
        allResponses.append(.error(response))
    }

    public func response(named: String) -> Response? {
        return allResponses.first(where: { response -> Bool in
            return response.name == named
        })
    }
    
    public func responds(to request: URLRequest, components: URLComponents) -> Bool {
        return evaluation.evaluate(request: request, components: components)
    }
    
    public var defaultResponse: Response? {
        return allResponses.first
    }
}
