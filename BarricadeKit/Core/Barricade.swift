//
//  Barricade.swift
//  Barricade
//
//  Created by John McIntosh on 5/5/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


public class Barricade: URLProtocol {
    
    public static func setup(with responseStore: ResponseStore) {
        // TODO: Implement
    }
    
    public static func setupWithInMemoreResponseStore() {
        // TODO: Implement
    }
    
    public static func enable() {
        // TODO: Implement
    }
    
    public static func disable() {
        // TODO: Implement
    }
    
    public static func enable(for sessionConfiguration: URLSessionConfiguration) {
        // TODO: Implement
    }

    public static func disable(for sessionConfiguration: URLSessionConfiguration) {
        // TODO: Implement
    }
    
    public static var responseStore: ResponseStore?
    
    public static var allRequestsBarricaded: Bool = true {
        didSet {
            // TODO: Implement
        }
    }
    
    public static var responseDelay: TimeInterval = 0.0
    
    public static func register(set: ResponseSet) {
        // TODO: Implement
    }
    
    public static func unregister(set: ResponseSet) {
        // TODO: Implement
    }
    
    public static func selectResponse(for request: String, with name: String) {
        // TODO: Implement
    }
    
    public static func stubRequestsPassing(evaluation: ResponseSetEvaluation, with responseGenerator: (URLRequest) -> Response) {
        // TODO: Implement
    }
}
