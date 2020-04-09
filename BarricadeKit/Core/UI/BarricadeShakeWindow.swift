//
//  BarricadeShakeWindow.swift
//  Barricade
//
//  Created by John McIntosh on 5/9/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import UIKit


public class BarricadeShakeWindow: UIWindow {
    
    override public func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                if self.shouldPresentBarricade {
                    self.presentBarricade()
                }
            }
        }
    }
    
    public func presentBarricade() {
        guard let rootViewController = self.rootViewController else { return }
        var topViewController = rootViewController
        while topViewController.presentedViewController != nil {
            topViewController = topViewController.presentedViewController!
        }
        
        if !isBarricade(viewController: topViewController) {
            let viewController = BarricadeViewController()
            viewController.delegate = self
            let navController = UINavigationController(rootViewController: viewController)
            topViewController.present(navController, animated: true, completion: nil)
        }
    }
    
    public var isEnabled: Bool?
    
    private var shouldPresentBarricade: Bool {
        guard let enabled = isEnabled else {
            #if DEBUG
                return true
            #else
                return false
            #endif
        }
        return enabled
    }
    
    private func isBarricade(viewController: UIViewController) -> Bool {
        return viewController is BarricadeNavigationController
    }
}


extension BarricadeShakeWindow: ResponseSetViewControllerDelegate {
    
    public func didSelectDone(in viewController: ResponseSetViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
