//
//  LocationUpdatesManager.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation
import CoreLocation

class LocationUpdatesManager: NSObject, CLLocationManagerDelegate {
    //MARK:- Properties
    static let shared = LocationUpdatesManager()
    private var locationManager: CLLocationManager?
    private var lastUpdate: CLLocationCoordinate2D?
    private var distanceThreshold: Double = 500
    private var isUpdating = false
    var didExceedThreshold: ((_ loc: CLLocationCoordinate2D, _ firstUpdate: Bool)->())?
    
    //MARK:- Methods
    func startUpdatesIfNeeded() {
        if let manage = locationManager {
            if !isUpdating {
                manage.startUpdatingLocation() }
            return
        }
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.distanceFilter = kCLDistanceFilterNone
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
        isUpdating = true
    }
    
    func stopUpdates() {
        locationManager?.stopUpdatingLocation()
        isUpdating = false
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentUpdate = locations.last?.coordinate else { return }
        guard let lastUpdate = lastUpdate else {
            // first launch
            didExceedThreshold?(currentUpdate, true)
            self.lastUpdate = currentUpdate
            return
        }
        if CLLocation.distance(from: lastUpdate, to: currentUpdate) > distanceThreshold {
            didExceedThreshold?(currentUpdate, false)
            self.lastUpdate = currentUpdate
        }
    }
}
