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
    var id: String?
    var name: String?
    var formattedAddress: [String]?
    var image: FourSquarePhotoVMProtocol?
    
    // MARK:- JSON
    required init?(map: Map) {
        self.mapping(map: map)
    }
    
    
    func mapping(map: Map) {
        id <- map["venue.id"]
        name <- map["venue.name"]
        formattedAddress <- map["venue.location.formattedAddress"]
    }
}
