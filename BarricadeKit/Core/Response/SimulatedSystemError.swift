//
//  SimulatedSystemError.swift
//  BarricadeKit
//
//  Created by John McIntosh on 10/31/22.
//  Copyright © 2022 John T McIntosh. All rights reserved.
//

import Foundation


public struct SimulatedSystemError {
    
    @available(*, unavailable) init() { fatalError() }

    public struct URLError {

        @available(*, unavailable) init() { fatalError() }

        /*
         Domain= NSURLErrorDomain
         Code=-1009
         "The Internet connection appears to be offline."
         UserInfo={
             _kCFStreamErrorCodeKey=50,
             NSUnderlyingError=0x60000236cd50 {
                 Error Domain=kCFErrorDomainCFNetwork
                 Code=-1009 "(null)"
                 UserInfo={
                     _NSURLErrorNWPathKey=unsatisfied (No network route),
                     _kCFStreamErrorCodeKey=50,
                     _kCFStreamErrorDomainKey=1
                 }
             },
             _NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <41EE9A4D-1B79-4C41-B1DA-D9F043060377>.<1>,
             _NSURLErrorRelatedURLSessionTaskErrorKey=(
                 "LocalDataTask <41EE9A4D-1B79-4C41-B1DA-D9F043060377>.<1>"
             ),
             NSLocalizedDescription=The Internet connection appears to be offline.,
             NSErrorFailingURLStringKey=https://example.com/,
             NSErrorFailingURLKey=https://example.com/,
             _kCFStreamErrorDomainKey=1
          }
         */
        public static func notConnectedToInternet(_ url: URL) -> Error {
            NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: [
                NSLocalizedDescriptionKey: "The Internet connection appears to be offline.",
                NSURLErrorFailingURLStringErrorKey: url.absoluteString,
                NSURLErrorFailingURLErrorKey: url.absoluteString
            ])
        }

        /*
         Domain= NSURLErrorDomain
         Code=-1001
         "The request timed out."
         UserInfo={
             _kCFStreamErrorCodeKey=-2102,
             NSUnderlyingError=0x60000027dd70 {
                 Error Domain=kCFErrorDomainCFNetwork
                 Code=-1001 "(null)"
                 UserInfo={
                     _kCFStreamErrorCodeKey=-2102,
                     _kCFStreamErrorDomainKey=4
                 }
             },
             _NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <73DE6821-C0A6-4D1B-AC29-2F138EF31843>.<1>,
             _NSURLErrorRelatedURLSessionTaskErrorKey=("LocalDataTask <73DE6821-C0A6-4D1B-AC29-2F138EF31843>.<1>"),
             NSLocalizedDescription=The request timed out.,
             NSErrorFailingURLStringKey=https://example.com/,
             NSErrorFailingURLKey=https://example.com/,
             _kCFStreamErrorDomainKey=4
          }
         */
        public static func timedOut(_ url: URL) -> Error {
            NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: [
                NSLocalizedDescriptionKey: "The request timed out.",
                NSURLErrorFailingURLStringErrorKey: url.absoluteString,
                NSURLErrorFailingURLErrorKey: url.absoluteString
            ])
        }
    }
}
