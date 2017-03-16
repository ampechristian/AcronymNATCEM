//
//  AcronymTable++.swift
//  Acronym
//
//  Created by Ampe on 3/15/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import UIKit

// Delegate Pattern (Data Source)
extension AcronymTable: DataModelDelegate {
    func didRecieveDataUpdate(data: [String]) {
        self.acronyms = data
    }
}

// Search Bar Update
extension AcronymTable: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        acronymModel.request(acronym: searchText)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
