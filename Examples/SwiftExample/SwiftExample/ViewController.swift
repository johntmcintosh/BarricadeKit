//
//  ViewController.swift
//  SwiftExample
//
//  Created by John McIntosh on 5/10/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import BarricadeKit
import Tweaks
import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var statusCodeLabel: UILabel!
    @IBOutlet weak var responseHeadersTextView: UITextView!
    @IBOutlet weak var responseTextView: UITextView!

    //
    // Standard Barricade UI Presentation
    //
    // To present the standard barricade UI manually, create an instance of `BarricadeNavigationController` and present it.
    //
    
    @IBAction func presentBarricadePressed() {
        let viewController = BarricadeNavigationController()
        viewController.barricadeDelegate = self
        present(viewController, animated: true, completion: nil)
    }
    
    // 
    // Facebook Tweaks integrated presentation
    // 
    // To present the barricade UI from within Facebook tweaks, create a tweak-action which finds the Tweaks navigation
    // controller, and then push an instance of BarricadeViewController onto the navigation stack.
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweakAction(categoryName: "Barricade", collectionName: "Local Server", tweakName: "Barricade") {
            let vc = BarricadeViewController()
            let tweaksNavController = UIApplication.shared.keyWindow?.topViewController() as? UINavigationController
            tweaksNavController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func presentTweaksPressed(){
        let viewController = FBTweakViewController(store: FBTweakStore.sharedInstance())!
        viewController.tweaksDelegate = self
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func triggerRequestPressed() {
        // Fetch the top 5 most starred Swift repositories on Github
        let url = URL(string: "https://api.github.com/search/repositories?q=language:Swift&sort=stars&order=desc&per_page=5")!
        let task = URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            guard let httpResponse = urlResponse as? HTTPURLResponse else { return }
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.statusCodeLabel.text = String(describing: httpResponse.statusCode)
                self.responseHeadersTextView.text = self.outputString(from: httpResponse.allHeaderFields)
                self.responseTextView.text = String(data: data, encoding: .utf8)
            }
        }
        task.resume()
    }
    
    private func outputString(from: [AnyHashable: Any]) -> String? {
        guard let headers = from as? [String: String] else { return nil }
        var output = "{\n"
        for (key, value) in headers {
            output += "\t\(key) = \(value)\n"
        }
        output += "}"
        return output
    }
}


extension ViewController: BarricadeNavigationControllerDelegate {

    func didSelectDone(in viewController: BarricadeNavigationController) {
        dismiss(animated: true, completion: nil)
    }
}


extension ViewController: FBTweakViewControllerDelegate {
    
    func tweakViewControllerPressedDone(_ tweakViewController: FBTweakViewController!) {
        dismiss(animated: true, completion: nil)
    }
}


private extension UIWindow {
    
    func topViewController() -> UIViewController? {
        if var viewController = self.rootViewController {
            while (viewController.presentedViewController != nil) {
                viewController = viewController.presentedViewController!
            }
            return viewController
        }
        return nil
    }
}
