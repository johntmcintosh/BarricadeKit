//
//  InMemoryResponseStoreTests.swift
//  Barricade
//
//  Created by John McIntosh on 5/8/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

@testable import BarricadeKit
import XCTest


class InMemoryResponseStoreTests: XCTestCase {
    
    var responseStore: ResponseStore!
    
    override func setUp() {
        super.setUp()
        responseStore = InMemoryResponseStore()
    }
    
    
    // MARK: Registration
    
    func testCanRegisterResponseSet() {
        responseStore.register(set: .makeSetA())
        responseStore.register(set: .makeSetB())
        
        XCTAssertEqual(responseStore.responseSets.count, 2)
    }
    
    func testSetOrderMatchesRegistrationOrder() {
        responseStore.register(set: .makeSetA())
        responseStore.register(set: .makeSetB())
        
        XCTAssertEqual(responseStore.responseSets[0].requestName, "A")
        XCTAssertEqual(responseStore.responseSets[1].requestName, "B")
    }
    
    func testCanUnregisterResponseSet() {
        responseStore.register(set: .makeSetA())
        responseStore.register(set: .makeSetB())
        
        responseStore.unregister(set: .makeSetA())
        
        XCTAssertEqual(responseStore.responseSets.count, 1)
        XCTAssertEqual(responseStore.responseSets[0].requestName, "B")
    }
    
    
    // MARK: Selection Management
    
    func testCurrentResponseDefaultsToDefault() {
        responseStore.register(set: .makeSetA())
        
        let response = responseStore.currentResponse(for: .makeSetA())!
        XCTAssertEqual(response.name, "success")
    }
    
    func testCurrentResponseCanBeUpdated() {
        responseStore.register(set: .makeSetA())
        responseStore.selectCurrentResponse(in: .makeSetA(), named: "failure")
        
        let response = responseStore.currentResponse(for: .makeSetA())!
        XCTAssertEqual(response.name, "failure")
    }
    
    func testCurrentResponseCanBeResetToDefault() {
        responseStore.register(set: .makeSetA())
        responseStore.selectCurrentResponse(in: .makeSetA(), named: "failure")
        responseStore.resetSelections()
        
        let response = responseStore.currentResponse(for: .makeSetA())!
        XCTAssertEqual(response.name, "success")
    }
}


private extension ResponseSet {
    
    static func makeSetA() -> ResponseSet {
        var set = ResponseSet(requestName: "A", evaluation: .suffix("/a"))
        set.add(response: StandardNetworkResponse(name: "success", statusCode: 200, contentType: ContentType.applicationJson))
        set.add(response: StandardNetworkResponse(name: "failure", statusCode: 400, contentType: ContentType.applicationJson))
        return set
    }

    static func makeSetB() -> ResponseSet {
        var set = ResponseSet(requestName: "B", evaluation: .suffix("/b"))
        set.add(response: StandardNetworkResponse(name: "success", statusCode: 200, contentType: ContentType.applicationJson))
        set.add(response: StandardNetworkResponse(name: "failure", statusCode: 400, contentType: ContentType.applicationJson))
        return set
    }
}
