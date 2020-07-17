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
    func fetchVenues(for location: (Double, Double), isFirstLoad: Bool)
    func venue(for index: Int) -> FourSquareVenueVMProtocol?
    func fetchImage(for venue: String, at: IndexPath)
}

class MainVCViewModel {
    
    //MARK:- Properties
    private weak var view: MainVCProtocol?
    private var api: FourSquareAPIProtocol?
    private var venues: [FourSquareVenueVMProtocol] = []
    private var limit = 20
    private var page = 0
    private var totalItems = 0
    private let semaphore = DispatchSemaphore(value: 1)
}

extension MainVCViewModel: MainVCViewModelProtocol {
    
    var numberOfRows: Int? {
        return venues.count
    }
    
    func setDependencies(view: MainVCProtocol?, api: FourSquareAPIProtocol?) {
        self.view = view
        self.api = api
    }
    
    func fetchVenues(for location: (Double, Double), isFirstLoad: Bool) {
        if !isFirstLoad && venues.count >= totalItems { return }
        if isFirstLoad {
            venues.removeAll()
            page = 0
            totalItems = 0
        }
        api?.getLocations(lat: location.0, lon: location.1, offset: page*limit, limit: limit) { [weak self] (result) in
            switch result {
            case .success(let res):
                self?.page += 1
                self?.totalItems = res?.totalItems ?? 0
                self?.venues += (res?.items ?? []).map({FourSquareVenueVM(venue: $0)})
                self?.view?.dataFetched()
            case .failure(let error):
                print(error)
                self?.view?.showError(message: error.userInfo[NSLocalizedDescriptionKey] as? String ?? "")
            }
        }
    }
    
    func venue(for index: Int) -> FourSquareVenueVMProtocol? {
        return venues[index]
    }
    
    func fetchImage(for venue: String, at: IndexPath) {
        api?.getPhotos(for: venue) { [weak self] (result) in
            switch result {
            case .success(let response):
//                guard let photo = response else { return }
                self?.semaphore.wait()
                self?.venues[at.row].image = FourSquarePhotoVM(photo: response ?? FourSquareVenuePhoto())
                self?.view?.imageLoaded(for: at)
                self?.semaphore.signal()
            case .failure(let error):
                print(error)
                self?.view?.showError(message: error.userInfo[NSLocalizedDescriptionKey] as? String ?? "")
            }
        }
    }
}
