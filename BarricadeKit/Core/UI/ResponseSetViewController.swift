//
//  ResponseSetViewController.swift
//  Barricade
//
//  Created by John McIntosh on 5/9/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


protocol ResponseSetViewControllerDelegate: class {
    func didSelectDone(in viewController: ResponseSetViewController)
}


class ResponseSetViewController: UIViewController {
    
    weak var delegate: ResponseSetViewControllerDelegate?
    
    lazy var responseStore: ResponseStore = {
        return Barricade.responseStore
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    
    // MARK: View Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("Barricade", comment: "")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePressed))

        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selected = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selected, animated: animated)
            tableView.reloadRows(at: [selected], with: .automatic)
        }
    }
    

    // MARK: Actions
    
    @objc private func resetPressed() {
        responseStore.resetSelections()
        tableView.reloadData()
    }

    @objc private func donePressed() {
        delegate?.didSelectDone(in: self)
    }
}


extension ResponseSetViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseStore.responseSets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") else {
                return UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
            }
            return cell
        }()
        
        let set = responseStore.responseSets[indexPath.row]
        cell.textLabel?.text = set.requestName
        
        let selected = responseStore.currentResponse(for: set)
        cell.detailTextLabel?.text = selected?.name
        
        return cell
    }
}


extension ResponseSetViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let set = responseStore.responseSets[indexPath.row]
        let vc = ResponseSelectionViewController(set: set)
        navigationController?.pushViewController(vc, animated: true)
    }
}
