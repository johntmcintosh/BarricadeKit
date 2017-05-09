//
//  AppDelegate.swift
//  Barricade
//
//  Created by John McIntosh on 5/5/17.
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

        
        var set = ResponseSet(requestName: "login", evaluation: .always())
        
        var response = StandardNetworkResponse(name: "success", statusCode: 200, contentType: ContentType.textPlain)
        response.contentString = "response body"
        set.add(response: response)
        
        let error = StandardErrorResponse(name: "error", error: BarricadeError.unknown)
        set.add(response: error)
        
        Barricade.register(set: set)
        
        return true
    }
}
