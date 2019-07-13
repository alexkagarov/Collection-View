//
//  ResponseModel.swift
//  Collection View
//
//  Created by Alex Kagarov on 7/13/19.
//  Copyright © 2019 Alex Kagarov. All rights reserved.
//

import Foundation

class Response: Decodable {
    var avatarUrl: String?
    var login: String?
    var type: String?
    var id: Int?
    var siteAdmin: Bool?
}
