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
    private var viewModel: MainVCViewModelProtocol?
    private var loadingData = true
    private var currentLocation: CLLocationCoordinate2D?
    private var errorView: ErrorView?
    private var shownIndexes : [IndexPath] = [] // used for cells animation
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
        LocationUpdatesManager.shared.didExceedThreshold = { [weak self] (location, isFirstUpdate) in
            self?.currentLocation = location
            self?.loadingData = true
            self?.viewModel?.fetchVenues(for: (location.latitude,location.longitude), isFirstLoad: true)
            if isFirstUpdate {
                if UserDefaultsManager.shared.appModeKey == .realTime {
                    self?.startRealTime()
                } else {
                    self?.stopRealTime()
                }
            }
        }
        LocationUpdatesManager.shared.startUpdatesIfNeeded()
        setupNavigationButton()
    }
    
    @objc func stopRealTime() {
        UserDefaultsManager.shared.appModeKey = .singleUpdate
        setupNavigationButton()
        LocationUpdatesManager.shared.stopUpdates()
    }
    
    @objc func startRealTime() {
        UserDefaultsManager.shared.appModeKey = .realTime
        setupNavigationButton()
        LocationUpdatesManager.shared.startUpdatesIfNeeded()
        
    }
    
    private func setupNavigationButton() {
        if UserDefaultsManager.shared.appModeKey == .realTime {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Stop RealTime", style: .plain, target: self, action: #selector(stopRealTime))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start RealTime", style: .plain, target: self, action: #selector(startRealTime))
        }
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
        
        if (shownIndexes.contains(indexPath) == false) {
            shownIndexes.append(indexPath)
            
            cell.transform = CGAffineTransform(translationX: 0, y: 55)
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 10, height: 10)
            cell.alpha = 0
            
            UIView.beginAnimations("rotation", context: nil)
            UIView.setAnimationDuration(0.5)
            cell.transform = CGAffineTransform(translationX: 0, y: 0)
            cell.alpha = 1
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            UIView.commitAnimations()
        }
    }
}

extension MainVC: MainVCProtocol {
    func dataFetched() {
        hideErrorView()
        loadingData = false
        venuesTable.stopLoading()
        if viewModel?.numberOfRows == 0 {
            showErrorView(message: "No Results !\nTry moving around", image: UIImage(named: "noData")!)
        }
        venuesTable.reloadData()
    }
    
    func showError(message: String) {
        showErrorView(message: message, image: UIImage(named: "errorIcon")!)
    }
    
    func imageLoaded(for index: IndexPath) {
        guard let venue = viewModel?.venue(for: index.row) else { return }
        (venuesTable.cellForRow(at: index) as? VenueCell)?.update(with: venue)
    }
    
    private func showErrorView(message: String, image: UIImage) {
        hideErrorView()
        errorView = ErrorView(frame: venuesTable.frame)
        errorView?.updateWith(image: image, text: message)
        errorView?.alpha = 0
        self.view.addSubview(errorView!)
        UIView.animate(withDuration: 0.2) { [weak errorView] in
            errorView?.alpha = 1
        }
    }
    
    private func hideErrorView() {
        if let errorView = errorView {
            UIView.animate(withDuration: 0.2, animations: { [weak errorView] in
                errorView?.alpha = 0
            }) { [weak errorView] (_) in
                errorView?.removeFromSuperview()
            }
        }
    }
}

