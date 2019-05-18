//
//  ResponseSetEvaluation.swift
//  Barricade
//
//  Created by John McIntosh on 5/8/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


public struct ResponseSetEvaluation {
    
    public typealias Evaluation = (URLRequest, URLComponents) -> Bool
    private var internalClosure: Evaluation
    
    public init(closure: @escaping Evaluation) {
        self.internalClosure = closure
    }
    
    func evaluate(request: URLRequest, components: URLComponents) -> Bool {
        return internalClosure(request, components)
    }
}


extension ResponseSetEvaluation {
    
    public static func always() -> ResponseSetEvaluation {
        return ResponseSetEvaluation { _, _ -> Bool in
            return true
        }
    }

    public static func contains(_ string: String) -> ResponseSetEvaluation {
        return ResponseSetEvaluation(closure: { (_, components) -> Bool in
            return components.path.contains(string)
        })
    }

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
}
