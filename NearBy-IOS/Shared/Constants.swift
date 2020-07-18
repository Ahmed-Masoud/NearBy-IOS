//
//  Constants.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation

enum App: String {
    case fourSquareClientID = "RMZAMLPU5LK4Z5S2AEC3UHPXW1KJKA1F2QH1HCCZOS0Z3KWQ"
    case fourSquareClientSecret = "GSNPTBZW3SBFKJ3CET3IBRT4IMH24L5ZADKV1ZVR0D3NQCV5"
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
