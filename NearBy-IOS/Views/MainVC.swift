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
    @IBOutlet weak var venuesTable: UITableView!
    
    //MARK:- Properties
    var viewModel: MainVCViewModelProtocol?
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        venuesTable.rowHeight = UITableView.automaticDimension
        venuesTable.estimatedRowHeight = 600
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

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "\(VenueCell.self)", for: indexPath) as? VenueCell, let venue = viewModel?.venue(for: indexPath.row) {
            cell.update(with: venue)
            return cell
        }
        return UITableViewCell()
    }
}

extension MainVC: MainVCProtocol {
    func dataFetched() {
        venuesTable.reloadData()
    }
    
    func showError(message: String) {
        
    }
}

