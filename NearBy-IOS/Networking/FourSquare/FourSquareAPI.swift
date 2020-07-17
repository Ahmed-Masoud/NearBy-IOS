//
//  FourSquareAPI.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation

protocol FourSquareAPIProtocol {
    func getLocations(lat: Double, lon: Double, completion: @escaping (Result<FourSquareVenueModelResponse?, NSError>) -> Void)
}


class FourSquareAPI: BaseAPI<FourSquareNetworking>, FourSquareAPIProtocol {
    
    //MARK:- Requests
    
    func getLocations(lat: Double, lon: Double, completion: @escaping (Result<FourSquareVenueModelResponse?, NSError>) -> Void) {
        self.fetchData(target: .getLocations(lat: lat, lon: lon), responseClass: FourSquareVenueModelResponse.self) { (result) in
            completion(result)
        }
    }
}
