//
//  MainVC.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import UIKit

protocol MainVCProtocol: class {
    func dataFetched()
    func showError(message: String)
}

class MainVC: UIViewController {
    //MARK:- Outlets
    
    //MARK:- Properties
    var viewModel: MainVCViewModelProtocol?
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationUpdatesManager.shared.startUpdates()
        LocationUpdatesManager.shared.didExceedThreshold = { [weak self] (location) in
            self?.viewModel?.fetchVenues(for: (location.latitude,location.longitude))
        }
    }
    
    //MARK:- Methods
    class func create(viewModel: MainVCViewModelProtocol) -> MainVC {
        let currentVC: MainVC = UIViewController.create(storyboard: StoryBoard.main, identifier: "\(MainVC.self)")
        viewModel.setDependencies(view: currentVC, api: FourSquareAPI())
        currentVC.viewModel = viewModel
        return currentVC
    }
    
}

extension MainVC: MainVCProtocol {
    func dataFetched() {
        
    }
    
    func showError(message: String) {
        
    }
}

