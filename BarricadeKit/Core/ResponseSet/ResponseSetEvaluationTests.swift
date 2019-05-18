//
//  ResponseSetEvaluationTests.swift
//  Barricade
//
//  Created by John McIntosh on 5/8/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

@testable import BarricadeKit
import XCTest


class ResponseSetEvaluationTests: XCTestCase {
    
    func testCustomEvaluation_pass() {
        let request = URLRequest(url: URL(string: "https://swift.org")!)
        let components = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)!

        let evaluation = ResponseSetEvaluation.closure { request, components in
            return components.host == "https"
        }
        let result = evaluation.evaluate(request: request, components: components)
        
        XCTAssertFalse(result)
    }

    func testCustomEvaluation_fail() {
        let request = URLRequest(url: URL(string: "https://swift.org")!)
        let components = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)!

        let evaluation = ResponseSetEvaluation.closure { request, components in
            return components.host == "http"
        }
        let result = evaluation.evaluate(request: request, components: components)
        
        XCTAssertFalse(result)
    }
    
    func testSuffix_pass() {
        let request = URLRequest(url: URL(string: "https://example.com/api/endpoint")!)
        let components = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)!

        let evaluation = ResponseSetEvaluation.suffix("/api/endpoint")
        let result = evaluation.evaluate(request: request, components: components)
        
        XCTAssertTrue(result)
    }
    
    func testSuffix_fail() {
        let request = URLRequest(url: URL(string: "https://example.com/api/other-endpoint")!)
        let components = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)!
        
        let evaluation = ResponseSetEvaluation.suffix("/api/endpoint")
        let result = evaluation.evaluate(request: request, components: components)
        
        XCTAssertFalse(result)
    }

    func testContains_pass() {
        let request = URLRequest(url: URL(string: "https://example.com/api/other-endpoint")!)
        let components = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)!

        let evaluation = ResponseSetEvaluation.contains("/api/endpoint")
        let result = evaluation.evaluate(request: request, components: components)

        XCTAssertTrue(result)
    }

    func testContains_fail() {
        let request = URLRequest(url: URL(string: "https://example.com/api/other-endpoint")!)
        let components = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)!

        let evaluation = ResponseSetEvaluation.contains("/api/endpoint")
        let result = evaluation.evaluate(request: request, components: components)

        XCTAssertFalse(result)
    }

}
