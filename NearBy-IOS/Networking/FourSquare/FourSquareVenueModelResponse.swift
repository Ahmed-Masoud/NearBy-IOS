//
//  FourSquareVenueModelResponse.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation
import ObjectMapper

class FourSquareVenueModelResponse: Mappable {
    var items: [FourSquareVenueModel]?
    
    // MARK:- JSON
    required init?(map: Map) {
        self.mapping(map: map)
    }
    
    
    func mapping(map: Map) {
        items <- map["response.groups.0.items"]
    }
}
