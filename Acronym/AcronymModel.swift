//
//  AcronymModel.swift
//  Acronym
//
//  Created by Ampe on 3/15/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

// Delegate Pattern
protocol DataModelDelegate: class {
    func didRecieveDataUpdate(data: [String])
}

class AcronymModel {
    
    private let url = "http://www.nactem.ac.uk/software/acromine/dictionary.py"
    
    weak var delegate: DataModelDelegate?
    
    // Retrieve JSON W/ Search Pattern
    func request(acronym: String) {
        Alamofire.request(url, parameters: ["sf": acronym], encoding: URLEncoding(destination: .methodDependent)).responseJSON { response in
            switch response.result {
            case .success(let value):
                self.parse(json: JSON(value))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // Parse JSON
    private func parse(json: JSON) {
        var array = [String]()
        let responses = json[0]["lfs"]
        for block in responses {
            array.append(block.1["lf"].stringValue)
        }
        delegate?.didRecieveDataUpdate(data: array)
    }
}
