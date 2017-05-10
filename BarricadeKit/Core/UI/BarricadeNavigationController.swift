//
//  BarricadeViewController.swift
//  Barricade
//
//  Created by John McIntosh on 5/9/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


public protocol BarricadeViewControllerDelegate: class {
    func didSelectDone(in viewController: BarricadeViewController)
}


public class BarricadeViewController: UINavigationController {
    
    public weak var barricadeDelegate: BarricadeViewControllerDelegate?
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        let vc = ResponseSetViewController()
        vc.delegate = self
        pushViewController(vc, animated: false)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension BarricadeViewController: ResponseSetViewControllerDelegate {
    
    func didSelectDone(in viewController: ResponseSetViewController) {
        barricadeDelegate?.didSelectDone(in: self)
    }
}
