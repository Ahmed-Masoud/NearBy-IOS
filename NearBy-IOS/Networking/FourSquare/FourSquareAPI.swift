//
//  FourSquareAPI.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation

protocol FourSquareAPIProtocol {
    func getLocations(lat: Double, lon: Double, offset: Int, limit: Int, completion: @escaping (Result<FourSquareVenueModelResponse?, NSError>) -> Void)
    func getPhotos(for venue: String, completion: @escaping (Result<FourSquareVenuePhoto?, NSError>) -> Void)
    
}


class FourSquareAPI: BaseAPI<FourSquareNetworking>, FourSquareAPIProtocol {
    
    //MARK:- Requests
    
    func getLocations(lat: Double, lon: Double, offset: Int, limit: Int, completion: @escaping (Result<FourSquareVenueModelResponse?, NSError>) -> Void) {
        self.fetchData(target: .getLocations(lat: lat, lon: lon, offset: offset, limit: limit), responseClass: FourSquareVenueModelResponse.self) { (result) in
            completion(result)
        }
    }
    
    func getPhotos(for venue: String, completion: @escaping (Result<FourSquareVenuePhoto?, NSError>) -> Void) {
        self.fetchData(target: .getImages(venue: venue), responseClass: FourSquareVenuePhoto.self) { (result) in
            completion(result)
        }
    }
}
