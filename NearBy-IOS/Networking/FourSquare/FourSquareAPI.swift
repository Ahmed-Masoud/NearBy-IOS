//
//  FourSquareAPI.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation

protocol FourSquareAPIProtocol {
    func getLocations(completion: @escaping (Result<FourSquareMainResponse?, NSError>) -> Void)
}


class FourSquareAPI: BaseAPI<FourSquareNetworking>, FourSquareAPIProtocol {
    
    //MARK:- Requests
    
    func getLocations(completion: @escaping (Result<FourSquareMainResponse?, NSError>) -> Void) {
        self.fetchData(target: .getLocations, responseClass: FourSquareMainResponse.self) { (result) in
            completion(result)
        }
    }
}