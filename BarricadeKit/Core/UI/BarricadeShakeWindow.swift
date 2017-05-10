//
//  BarricadeShakeWindow.swift
//  Barricade
//
//  Created by John McIntosh on 5/9/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


public class BarricadeShakeWindow: UIWindow {
    
    override public func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
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
            let navController = BarricadeViewController()
            navController.barricadeDelegate = self
            topViewController.present(navController, animated: true, completion: nil)
        }
    }
    
    var shouldPresentBarricade: Bool {
        return true
    }
    
    func isBarricade(viewController: UIViewController) -> Bool {
        return viewController is BarricadeViewController
    }
}


extension BarricadeShakeWindow: BarricadeViewControllerDelegate {
    
    public func didSelectDone(in viewController: BarricadeViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
