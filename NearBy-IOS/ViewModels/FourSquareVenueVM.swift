//
//  FourSquareVenueVM.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation

protocol FourSquareVenueVMProtocol {
    var name: String? { get }
    var address: String { get }
}

class FourSquareVenueVM: FourSquareVenueVMProtocol {
    
    var venue: FourSquareVenueModel?
    
    init(venue: FourSquareVenueModel) {
        self.venue = venue
    }
    
    var name: String? {
        return venue?.name
    }
    
    var address: String {
        var finalString = ""
        venue?.formattedAddress?.forEach({finalString += "\($0),"})
        finalString.removeLast() // removes lat , in string
        return finalString
    }
}
