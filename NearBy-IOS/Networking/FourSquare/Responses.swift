//
//  Responses.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation

class FourSquareMainResponse: Codable {
    var response: FourSquareResponse?
}

class FourSquareResponse: Codable {
    var groups: [FourSquareGroup]?
}

class FourSquareGroup: Codable {
    var items: [FourSquareItem]?
}

class FourSquareItem: Codable {
    var venue: FourSquareVenue?
}
