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
        
        var response = StandardNetworkResponse(name: "success", statusCode: 200, contentType: ContentType.textPlain)
        response.contentString = "response body"
        set.add(response: response)
        
        var response2 = StandardNetworkResponse(name: "failure", statusCode: 400, contentType: ContentType.textPlain)
        response2.contentString = "response failure"
        set.add(response: response2)
        
        let error = StandardErrorResponse(name: "error", error: BarricadeError.unknown)
        set.add(response: error)
        
        return set
    }
}

/*
[responseSet addResponseWithName:@"success"
    file:MMPathForFileInMainBundleDirectory(@"search.success.json", @"LocalServerFiles")
    statusCode:200
    contentType:@"application/json"];

[responseSet addResponseWithName:@"no results"
    file:MMPathForFileInMainBundleDirectory(@"search.empty.json", @"LocalServerFiles")
    statusCode:200
    contentType:@"application/json"];

[responseSet addResponseWithName:@"rate limited"
    file:MMPathForFileInMainBundleDirectory(@"search.ratelimited.json", @"LocalServerFiles")
    statusCode:403
    headers:@{
    @"X-RateLimit-Limit": @"60",
    @"X-RateLimit-Remaining": @"0",
    @"X-RateLimit-Reset": @"1377013266",
    MMBarricadeContentTypeHeaderKey: @"application/json",
    }];

[MMBarricade registerResponseSet:responseSet];
*/
