//
//  StandardNetworkResponse.swift
//  Barricade
//
//  Created by John McIntosh on 5/8/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

@testable import BarricadeKit
import XCTest


class StandardNetworkResponseTests: XCTestCase {
    
    // MARK: Content type
    
    func testAllHeaders_contentTypeOnly() {
        let response = StandardNetworkResponse.makeForTest(contentType: ContentType.applicationJson)
        
        XCTAssertEqual(response.allHeaderFields, ["Content-Type": "application/json"])
    }
    
    func testAllHeaders_contentTypeAndCustom() {
        var response = StandardNetworkResponse.makeForTest(contentType: ContentType.applicationJson)
        response.customHeaderFields = [
            "key1": "value1",
            "key2": "value2"
        ]
        
        XCTAssertEqual(response.allHeaderFields, [
            "Content-Type": "application/json",
            "key1": "value1",
            "key2": "value2"
            ])
    }
    
    func testAllHeaders_contentTypeOverridesCustom() {
        var response = StandardNetworkResponse.makeForTest(contentType: ContentType.applicationJson)
        response.customHeaderFields = [
            "Content-Type": ContentType.textPlain,
            "key1": "value1",
            "key2": "value2"
        ]
        
        XCTAssertEqual(response.allHeaderFields, [
            "Content-Type": "application/json",
            "key1": "value1",
            "key2": "value2"
            ])
    }
    
    
    // MARK: Content String/Data
    
    func testNilContentReturnsNilContentString() {
        var response = StandardNetworkResponse.makeForTest(contentType: ContentType.textPlain)
        response.content = nil
        
        XCTAssertNil(response.contentString)
    }
    
    func testSettingContentStringSetsContentData() {
        var response = StandardNetworkResponse.makeForTest(contentType: ContentType.textPlain)
        response.contentString = "sample response string"
        
        XCTAssertEqual(response.content, "sample response string".data(using: .utf8))
    }
    
    func testSettingContentDataSetsContentString() {
        var response = StandardNetworkResponse.makeForTest(contentType: ContentType.textPlain)
        response.content = "sample response string".data(using: .utf8)

        XCTAssertEqual(response.contentString, "sample response string")
    }
    
    
    // MARK: Response modifications
    
    // TODO: Implement
}


private extension StandardNetworkResponse {
    
    static func makeForTest(contentType: String) -> StandardNetworkResponse {
        return StandardNetworkResponse(name: "default", statusCode: 200, contentType: contentType)
    }
}
