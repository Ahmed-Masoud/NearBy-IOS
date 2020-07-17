//
//  FourSquareNetworking.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation
import Alamofire

enum FourSquareNetworking {
    case getLocations(lat: Double, lon: Double)
}

extension FourSquareNetworking: TargetType {
    var baseURL: String {
        switch self {
        default:
            return "https://api.foursquare.com/v2"
        }
    }
    
    var path: String {
        switch self {
        case .getLocations:
            return "/venues/explore"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getLocations:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .getLocations(lat, lon):
            let params: [String: Any] = [
                "ll": "\(lat),\(lon)",
                "client_id": App.fourSquareClientID.rawValue,
                "client_secret": App.fourSquareClientSecret.rawValue,
                "v": "20190425"
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
}
