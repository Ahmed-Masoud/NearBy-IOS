//
//  FourSquareVenue.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation
import ObjectMapper

class FourSquareVenueModel: Mappable {
    var name: String?
    var formattedAddress: [String]?
    
    // MARK:- JSON
    required init?(map: Map) {
        self.mapping(map: map)
    }
    
    
    func mapping(map: Map) {
        name <- map["venue.name"]
        formattedAddress <- map["venue.location.formattedAddress"]
    }
}
