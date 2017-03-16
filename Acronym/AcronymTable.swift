//
//  AcronymTable.swift
//  Acronym
//
//  Created by Ampe on 3/15/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import UIKit

class AcronymTable: UITableViewController {
    
    // IBOutlets
    @IBOutlet var searchBar: UISearchBar!
    
    // Model Initialization
    let acronymModel = AcronymModel()
    
    // Mutable Data (Updates TableView On Change)
    var acronyms = [String]() {
        didSet { tableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        acronymModel.delegate = self
    }
    
    // MARK: - Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acronyms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = acronyms[indexPath.row]
        return cell
    }
}

