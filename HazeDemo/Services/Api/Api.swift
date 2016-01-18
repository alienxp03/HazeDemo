//
//  Api.swift
//  HazeDemo
//
//  Created by Muhammad Azuan Zira Zairein on 16/01/2016.
//  Copyright © 2016 Azuan. All rights reserved.
//

import UIKit

protocol Api {
    var baseApiUrl: String { get }
}

extension Api {
    var baseApiUrl: String {
        return "https://raw.githubusercontent.com/HazeWatchApp/apims_data/gh-pages/index_v2.json"
    }
    
    func request(endpoint endpoint: String) -> String {
        return "\(baseApiUrl)/api/\(endpoint)"
    }
}
