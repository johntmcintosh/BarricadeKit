//
//  BarricadeTests.swift
//  Barricade
//
//  Created by John McIntosh on 5/8/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

@testable import BarricadeKit
import XCTest


class BarricadeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Barricade.enableForDefaultSession()
    }
    
    override func tearDown() {
        Barricade.unregisterAll()
        Barricade.disableForDefaultSession()
        super.tearDown()
    }
    
    
    // MARK: Enabling
    
    func testSetsUpWithInMemoryResponseStoreByDefault() {
        XCTAssertTrue(Barricade.responseStore is InMemoryResponseStore)
    }

    func testCanMakeRequest_defaultSession() {
        Barricade.register(set: .make())
        
        let completionExpectation = expectation(description: "request completed")
        let task = URLSession.shared.dataTask(with: URL(string: "http://example.com")!) { data, urlResponse, error in
            
            let response = urlResponse as! HTTPURLResponse
            XCTAssertEqual(response.statusCode, 200)
            XCTAssertEqual(response.allHeaderFields[Header.contentType] as? String, ContentType.textPlain)
            XCTAssertEqual(String(data: data!, encoding: .utf8), "response body")
            completionExpectation.fulfill()
        }
        task.resume()
        waitForExpectations(timeout: 2.0, handler: nil)
    }

    func testCanMakeRequest_customSessionConfiguration() {
        let configuration = URLSessionConfiguration.default
        Barricade.enable(for: configuration)
        
        Barricade.register(set: .make())
        
        let completionExpectation = expectation(description: "request completed")
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: URL(string: "http://example.com")!) { data, urlResponse, error in
            
            let response = urlResponse as! HTTPURLResponse
            XCTAssertEqual(response.statusCode, 200)
            XCTAssertEqual(response.allHeaderFields[Header.contentType] as? String, ContentType.textPlain)
            XCTAssertEqual(String(data: data!, encoding: .utf8), "response body")
            completionExpectation.fulfill()
        }
        task.resume()
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    
    // MARK: Errors
    
    func testNoResponseRegistered() {
        let completionExpectation = expectation(description: "request completed")
        let task = URLSession.shared.dataTask(with: URL(string: "http://example.com")!) { data, urlResponse, error in
            
            let barricadeError = error as! BarricadeError
            //XCTAssertTrue(barricadeError is BarricadeError.noResponseRegistered)
            XCTAssertNil(data)
            completionExpectation.fulfill()
        }
        task.resume()
        waitForExpectations(timeout: 2.0, handler: nil)
    }
}

private extension ResponseSet {
    
    static func make() -> ResponseSet {
        var set = ResponseSet(requestName: "login", evaluation: .always())
        var response = StandardNetworkResponse(name: "success", statusCode: 200, contentType: ContentType.textPlain)
        response.contentString = "response body"
        set.add(response: response)
        return set
    }
}
