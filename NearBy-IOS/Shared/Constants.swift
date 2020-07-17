//
//  Constants.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation

enum App: String {
    case fourSquareClientID = "DFZVJNOZ41QUT3BTD4JOR3LJC4YUXWZZIPQTB04F4REJXK44"
    case fourSquareClientSecret = "JT1SB5DQQZCGF3QNOJ1EUFVFBML1WHJHX4452SG4AQWBQN3H"
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
