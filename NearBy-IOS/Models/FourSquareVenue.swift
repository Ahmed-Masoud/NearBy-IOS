//
//  FourSquareVenue.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation

class FourSquareVenue: Codable {
    var name: String?
    var formattedAddress: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case formattedAddress = "formattedAddress"
}
