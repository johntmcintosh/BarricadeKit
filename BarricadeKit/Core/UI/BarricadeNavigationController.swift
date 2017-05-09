//
//  BarricadeNavigationController.swift
//  Barricade
//
//  Created by John McIntosh on 5/9/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


class BarricadeNavigationController: UINavigationController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        let vc = ResponseSetViewController()
        vc.delegate = self
        pushViewController(vc, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension BarricadeNavigationController: ResponseSetViewControllerDelegate {
    
    func didSelectDone(in viewController: ResponseSetViewController) {
        dismiss(animated: true, completion: nil)
    }
}
