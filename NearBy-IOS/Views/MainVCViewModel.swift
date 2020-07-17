//
//  MainVCViewModel.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation

protocol MainVCViewModelProtocol {
    func setDependencies(view: MainVCProtocol?, api: FourSquareAPIProtocol?)
    func fetchVenues(for location: (Double, Double))
}

class MainVCViewModel {
    
    //MARK:- Properties
    private weak var view: MainVCProtocol?
    private var api: FourSquareAPIProtocol?
    
}

extension MainVCViewModel: MainVCViewModelProtocol {
    func setDependencies(view: MainVCProtocol?, api: FourSquareAPIProtocol?) {
        self.view = view
        self.api = api
    }
    
    func fetchVenues(for location: (Double, Double)) {
        api?.getLocations(lat: location.0, lon: location.1) { (result) in
            switch result {
            case .success(let res):
                res?.items?.forEach({print("\($0.name) => \($0.formattedAddress)")})
            case .failure(let error):
                print(error)
            }
        }
    }
}
