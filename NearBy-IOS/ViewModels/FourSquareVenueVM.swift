//
//  FourSquareVenueVM.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation

protocol FourSquareVenueVMProtocol {
    var id: String? { get }
    var name: String? { get }
    var address: String { get }
    var image: FourSquarePhotoVMProtocol? { get set }
}

class FourSquareVenueVM: FourSquareVenueVMProtocol {
    
    var venue: FourSquareVenueModel?
    
    init(venue: FourSquareVenueModel) {
        self.venue = venue
    }
    
    var id: String? {
        return venue?.id
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
    
    var image: FourSquarePhotoVMProtocol? {
        get {
            return venue?.image
        }
        set {
            venue?.image = newValue
        }
    }
}
