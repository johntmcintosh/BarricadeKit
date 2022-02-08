//
//  BarricadeViewController.swift
//  Barricade
//
//  Created by John McIntosh on 5/9/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import UIKit


public protocol BarricadeNavigationControllerDelegate: AnyObject {
    func didSelectDone(in viewController: BarricadeNavigationController)
}


public class BarricadeNavigationController: UINavigationController {
    
    public weak var barricadeDelegate: BarricadeNavigationControllerDelegate?
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        let vc = BarricadeViewController()
        vc.delegate = self
        pushViewController(vc, animated: false)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension BarricadeNavigationController: ResponseSetViewControllerDelegate {
    
    public func didSelectDone(in viewController: ResponseSetViewController) {
        guard let barricadeDelegate = barricadeDelegate else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        barricadeDelegate.didSelectDone(in: self)
    }
}
