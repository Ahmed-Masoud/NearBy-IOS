//
//  MainVCViewModel.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation

protocol MainVCViewModelProtocol {
    var numberOfRows: Int? { get }
    func setDependencies(view: MainVCProtocol?, api: FourSquareAPIProtocol?)
    func fetchVenues(for location: (Double, Double))
    func venue(for index: Int) -> FourSquareVenueVMProtocol?
}

class MainVCViewModel {
    
    //MARK:- Properties
    private weak var view: MainVCProtocol?
    private var api: FourSquareAPIProtocol?
    private var venues: [FourSquareVenueVMProtocol] = []
    
}

extension MainVCViewModel: MainVCViewModelProtocol {
    
    var numberOfRows: Int? {
        return venues.count
    }
    
    func setDependencies(view: MainVCProtocol?, api: FourSquareAPIProtocol?) {
        self.view = view
        self.api = api
    }
    
    func fetchVenues(for location: (Double, Double)) {
        api?.getLocations(lat: location.0, lon: location.1) { [weak self] (result) in
            switch result {
            case .success(let res):
                self?.venues = (res?.items ?? []).map({FourSquareVenueVM(venue: $0)})
                self?.view?.dataFetched()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func venue(for index: Int) -> FourSquareVenueVMProtocol? {
        return venues[index]
    }
}
