//
//  FourSquarePhoto.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation
import ObjectMapper

class FourSquareVenuePhoto: Mappable {
    var prefix: String?
    var suffix: String?
    
    init() {
        
    }
    
    // MARK:- JSON
    required init?(map: Map) {
        self.mapping(map: map)
    }
    
    func mapping(map: Map) {
        prefix <- map["response.photos.items.0.prefix"]
        suffix <- map["response.photos.items.0.suffix"]
    }
}
