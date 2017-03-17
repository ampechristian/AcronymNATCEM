//
//  AcronymModel.swift
//  Acronym
//
//  Created by Ampe on 3/15/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

// Delegate Pattern
protocol DataModelDelegate: class {
    func didRecieveDataUpdate(data: [String])
}

// Switch Between Using URLSession & Alamofire
enum Fetcher {
    case Alamofire
    case URLSession
}

class AcronymModel {
    
    // Set Fetcher Here (Default Is Alamofire)
    let DWNLDR = Fetcher.Alamofire
    
    // Default URLS
    private let url = "http://www.nactem.ac.uk/software/acromine/dictionary.py"
    private let requestUrl = "http://www.nactem.ac.uk/software/acromine/dictionary.py/get?sf="
    
    weak var delegate: DataModelDelegate?
    
    var array = [String]() {
        didSet { delegate?.didRecieveDataUpdate(data: array) }
    }
    
    // Fetch JSON Using DWNLDR
    func request(acronym: String) {
        switch DWNLDR {
        case .Alamofire:
            Alamofire.request(url, parameters: ["sf": acronym], encoding: URLEncoding(destination: .methodDependent)).responseJSON { response in
                switch response.result {
                case .success(let value):
                    self.parse(json: JSON(value))
                case .failure(let error):
                    print(error)
                }
            }
        case .URLSession:
            let urlString = URL(string: requestUrl+acronym)
            if let url = urlString {
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        print(error!)
                    } else {
                        if let usableData = data {
                            self.parse(json: JSON(usableData))
                        }
                    }
                }
                task.resume()
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
        self.array = array
    }
}
