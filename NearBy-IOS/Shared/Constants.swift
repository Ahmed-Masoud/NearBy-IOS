//
//  Constants.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation

enum App: String {
    case fourSquareClientID = "ZRFZ5SF351WF5OKRZKVL2PMWPSN5QX5M4DXOACWVYKSMCOD1"
    case fourSquareClientSecret = "ZRDJFSZLL5GHUKZTF1UWH1RV5FYHNKD0RMN2CNDEBKDWQWDN"
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
