//
//  Barricade.swift
//  Barricade
//
//  Created by John McIntosh on 5/5/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


class Barricade: URLProtocol {
    
    static func setup(with responseStore: ResponseStore) {
        // TODO: Implement
    }
    
    static func setupWithInMemoreResponseStore() {
        // TODO: Implement
    }
    
    static func enable() {
        // TODO: Implement
    }
    
    static func disable() {
        // TODO: Implement
    }
    
    static func enable(for sessionConfiguration: URLSessionConfiguration) {
        // TODO: Implement
    }

    static func disable(for sessionConfiguration: URLSessionConfiguration) {
        // TODO: Implement
    }
    
    static var responseStore: ResponseStore?
    
    static var allRequestsBarricaded: Bool = true {
        didSet {
            // TODO: Implement
        }
    }
    
    static var responseDelay: TimeInterval = 0.0
    
    static func register(set: ResponseSet) {
        // TODO: Implement
    }
    
    static func unregister(set: ResponseSet) {
        // TODO: Implement
    }
    
    static func selectResponse(for request: String, with name: String) {
        // TODO: Implement
    }
    
    static func stubRequestsPassing(evaluation: ResponseSet.Evaluation, with responseGenerator: (URLRequest) -> Response) {
        // TODO: Implement
    }
}
