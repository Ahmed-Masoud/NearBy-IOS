//
//  Constants.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation

enum App: String {
    case fourSquareClientID = "F25QS3GWAJNLJ3VGK511RR1JL1LBAIWPOJPMGKVTHP4U435Z"
    case fourSquareClientSecret = "QXZ5TCVO2VVJ5FLF2Q41O42KSAYZ24PSC4QWLNTP3RSEI3WO"
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
