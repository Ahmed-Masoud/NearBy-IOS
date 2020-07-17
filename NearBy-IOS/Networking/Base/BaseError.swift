//
//  BaseError.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseError: Mappable {
    var code: Int?
    var details: String?
    
    // MARK:- JSON
    required init?(map: Map) {
        self.mapping(map: map)
    }
    
    
    func mapping(map: Map) {
        code <- map["meta.code"]
        details <- map["meta.errorDetail"]
    }
}
