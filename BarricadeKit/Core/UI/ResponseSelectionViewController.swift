//
//  ResponseSelectionViewController.swift
//  Barricade
//
//  Created by John McIntosh on 5/9/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import UIKit


class ResponseSelectionViewController: UIViewController {
    
    let set: ResponseSet
    
    lazy var responseStore: ResponseStore = {
        return Barricade.responseStore
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.dataSource = self
        table.delegate = self
        return table
    }()

    
    // MARK: Initializers
    
    init(set: ResponseSet) {
        self.set = set
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: View Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = set.requestName
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}


extension ResponseSelectionViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return set.allResponses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") else {
                return UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
            }
            return cell
        }()
        
        let response = set.allResponses[indexPath.row]
        let selected = responseStore.currentResponse(for: set)

        cell.textLabel?.text = response.name
        cell.accessoryType = (response.name == selected?.name) ? .checkmark : .none
        
        return cell
    }
}


extension ResponseSelectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let response = set.allResponses[indexPath.row]
        Barricade.selectResponse(for: set.requestName, with: response.name)
        navigationController?.popViewController(animated: true)
    }
}
