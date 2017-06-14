//
//  ViewController.swift
//  SwiftExample
//
//  Created by John McIntosh on 5/10/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import BarricadeKit
import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var statusCodeLabel: UILabel!
    @IBOutlet weak var responseHeadersTextView: UITextView!
    @IBOutlet weak var responseTextView: UITextView!

    
    @IBAction func presentBarricadePressed() {
        let viewController = BarricadeNavigationController()
        viewController.barricadeDelegate = self
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
