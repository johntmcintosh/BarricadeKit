//
//  ResponseSet.swift
//  Barricade
//
//  Created by John McIntosh on 5/5/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


struct ResponseSet {
    
    typealias Evaluation = (URLRequest, URLComponents) -> Bool
    
    var requestName: String
    
    private(set) var allResponses: [Response]
    
    var evaluation: Evaluation

    init(requestName: String, evaluation: @escaping Evaluation) {
        self.requestName = requestName
        self.allResponses = []
        self.evaluation = evaluation
    }
    
    func add(response: Response) {
        // TODO: Implement
    }
    
    func createResponse(responseGenerator: ()->(Response)) {
        // TODO: Implement
    }
    
    func createResponse(name: String, hook: (Response) -> ()) {
        // TODO: Implement
    }
    
    func response(named: String) -> Response? {
        // TODO: Implement
        return nil
    }
}
