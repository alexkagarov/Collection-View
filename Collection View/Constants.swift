//
//  Constants.swift
//  Collection View
//
//  Created by Alex Kagarov on 7/13/19.
//  Copyright © 2019 Alex Kagarov. All rights reserved.
//

import Foundation

struct Constants {
    typealias DownloadCompleted = (Data) -> ()
    static let url = "https://api.github.com/users?since=0&per_page=100"
}

