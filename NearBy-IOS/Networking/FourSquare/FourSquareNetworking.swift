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
    case getLocations(lat: Double, lon: Double, offset: Int, limit: Int)
    case getImages(venue: String)
}

extension FourSquareNetworking: TargetType {
    var baseURL: String {
        switch self {
        default:
            return Server.fourSquareBaseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getLocations:
            return Endpoint.getVenues.rawValue
        case let .getImages(venue):
            return String(format: Endpoint.getVenuePhotos.rawValue, venue)
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getLocations, .getImages:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .getLocations(lat, lon, offset, limit):
            let params: [String: Any] = [
                "ll": "\(lat),\(lon)",
                "client_id": App.fourSquareClientID.rawValue,
                "client_secret": App.fourSquareClientSecret.rawValue,
                "v": "20190425",
                "offset": offset,
                "limit": limit,
                "radius": 1000
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .getImages:
            let params: [String: Any] = [
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
