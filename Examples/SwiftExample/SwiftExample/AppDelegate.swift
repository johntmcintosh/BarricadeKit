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
        Barricade.register(set: .makeTopRepositories())
        
        return true
    }
}


extension ResponseSet {
    
    static func makeTopRepositories() -> ResponseSet {
        let generator = FileBasedResponseGenerator(contentType: ContentType.applicationJson, directory: "LocalServer")

        var set = ResponseSet(requestName: "search", evaluation: .suffix("search/repositories"))
        set.add(response: generator.response(named: "success", file: "search.success.json", statusCode: 200))
        set.add(response: generator.response(named: "no results", file: "search.empty.json", statusCode: 200))
        set.add(response: generator.response(named: "rate limited", file: "search.ratelimited.json", statusCode: 403,
                                             headers: ["X-RateLimit-Limit": "60",
                                                       "X-RateLimit-Remaining": "0",
                                                       "X-RateLimit-Reset": "1377013266"]))
        return set
    }
}
