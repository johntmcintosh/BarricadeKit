//
//  SimulatedSystemErrorResponse.swift
//  BarricadeKit
//
//  Created by John McIntosh on 10/31/22.
//  Copyright © 2022 John T McIntosh. All rights reserved.
//

import Foundation


/**
 Namespace type for modeling common simulated system error responses.
 */
public struct SimulatedSystemErrorResponse {
    
    @available(*, unavailable) init() { fatalError() }

    /// Error response representing `NSURLErrorNotConnectedToInternet`
    public static func notConnectedToInternet(named name: String) -> ErrorResponse {
        StandardErrorResponse(name: name, errorGenerator: { request in
            let url = request.url ?? URL(string: "barricadekit://fallback-url")!
            return SimulatedSystemError.URLError.notConnectedToInternet(url)
        })
    }
    
    /// Error response representing `NSURLErrorTimedOut`
    public static func timedOut(named name: String) -> ErrorResponse {
        StandardErrorResponse(name: name, errorGenerator: { request in
            let url = request.url ?? URL(string: "barricadekit://fallback-url")!
            return SimulatedSystemError.URLError.timedOut(url)
        })
    }
}
