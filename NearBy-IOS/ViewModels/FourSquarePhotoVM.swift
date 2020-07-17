//
//  FourSquarePhotoVM.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation

protocol FourSquarePhotoVMProtocol {
    var url: String? { get }
}

class FourSquarePhotoVM: FourSquarePhotoVMProtocol {
    
    var photo: FourSquareVenuePhoto?
    
    init(photo: FourSquareVenuePhoto) {
        self.photo = photo
    }
    
    var url: String? {
        if let prefix = photo?.prefix, let suffix = photo?.suffix {
            return "\(prefix)original\(suffix)"
        }
        return nil
    }
}
