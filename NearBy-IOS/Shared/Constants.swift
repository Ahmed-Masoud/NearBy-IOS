//
//  Constants.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation

enum App: String {
    case fourSquareClientID = "XCU1VVZZ44ZUJC5LDXPUXH3L5FDYTGT2TEKXOJMLH1Z3HEXT"
    case fourSquareClientSecret = "BUST1DSKO0QXB4KXAIE2XHIL0KP2QYAHRHLAQ33FLIEEKYQR"
}

enum Server: String {
    case fourSquareBaseURL = "https://api.foursquare.com/v2"
}

enum Endpoint: String {
    case getVenues = "/venues/explore"
    case getVenuePhotos = "/venues/%@/photos"
}

enum StoryBoard: String {
    case main = "Main"
}
