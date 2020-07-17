//
//  MainVC.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import UIKit
import CoreLocation

protocol MainVCProtocol: class {
    func dataFetched()
    func showError(message: String)
    func imageLoaded(for index: IndexPath)
}

class MainVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var venuesTable: UITableView!
    
    //MARK:- Properties
    var viewModel: MainVCViewModelProtocol?
    private var loadingData = true
    private var currentLocation: CLLocationCoordinate2D?
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        venuesTable.startLoading()
    }
    
    //MARK:- Methods
    class func create(viewModel: MainVCViewModelProtocol) -> MainVC {
        let currentVC: MainVC = UIViewController.create(storyboard: StoryBoard.main, identifier: "\(MainVC.self)")
        viewModel.setDependencies(view: currentVC, api: FourSquareAPI())
        currentVC.viewModel = viewModel
        return currentVC
    }
    
    private func setup() {
        self.title = "Near By"
        venuesTable.rowHeight = UITableView.automaticDimension
        venuesTable.estimatedRowHeight = 600
        LocationUpdatesManager.shared.didExceedThreshold = { [weak self] (location) in
            self?.currentLocation = location
            self?.loadingData = true
            self?.viewModel?.fetchVenues(for: (location.latitude,location.longitude), isFirstLoad: true)
        }
        startRealTime()
    }
    
    @objc func stopRealTime() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start RealTime", style: .plain, target: self, action: #selector(startRealTime))
        LocationUpdatesManager.shared.stopUpdates()
    }
    
    @objc func startRealTime() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Stop RealTime", style: .plain, target: self, action: #selector(stopRealTime))
        LocationUpdatesManager.shared.startUpdates()
        
    }
    
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "\(VenueCell.self)", for: indexPath) as? VenueCell, let venue = viewModel?.venue(for: indexPath.row) {
            cell.update(with: venue)
            if venue.image == nil {
                viewModel?.fetchImage(for: venue.id ?? "", at: indexPath)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = (viewModel?.numberOfRows ?? 0) - 1
        if !loadingData && indexPath.row == lastElement {
            if let loc = currentLocation {
                loadingData = true
                self.viewModel?.fetchVenues(for: (loc.latitude, loc.longitude), isFirstLoad: false)
            }
        }
    }
}

extension MainVC: MainVCProtocol {
    func dataFetched() {
        loadingData = false
        venuesTable.stopLoading()
        venuesTable.reloadData()
    }
    
    func showError(message: String) {
        
    }
    
    func imageLoaded(for index: IndexPath) {
        guard let venue = viewModel?.venue(for: index.row) else { return }
        (venuesTable.cellForRow(at: index) as? VenueCell)?.update(with: venue)
    }
}

