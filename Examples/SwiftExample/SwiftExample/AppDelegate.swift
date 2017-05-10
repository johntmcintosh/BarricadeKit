//
//  AppDelegate.swift
//  SwiftExample
//
//  Created by John McIntosh on 5/10/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import BarricadeKit
import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = {
        return BarricadeShakeWindow(frame: UIScreen.main.bounds)
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Barricade.enableForDefaultSession()
        Barricade.register(set: .createdManually())
        
        return true
    }
}


extension ResponseSet {
    
    static func createdManually() -> ResponseSet {
        var set = ResponseSet(requestName: "search", evaluation: .suffix("search/repositories"))
        
        let successPath = BarricadeKit.url(for: "search.success.json", in: "LocalServer")!
        let success = Response.make(name: "success", path: successPath, statusCode: 200, contentType: ContentType.applicationJson)
        set.add(response: success)

        let noResultsPath = BarricadeKit.url(for: "search.empty.json", in: "LocalServer")!
        let noResults = Response.make(name: "no results", path: noResultsPath, statusCode: 200, contentType: ContentType.applicationJson)
        set.add(response: noResults)

        let rateLimitedPath = BarricadeKit.url(for: "search.ratelimited.json", in: "LocalServer")!
        let headers = ["X-RateLimit-Limit": "60",
                       "X-RateLimit-Remaining": "0",
                       "X-RateLimit-Reset": "1377013266"]
        let rateLimited = Response.make(name: "rate limited", path: rateLimitedPath, statusCode: 403, contentType: ContentType.applicationJson, headers: headers)
        set.add(response: rateLimited)

        return set
    }
}
