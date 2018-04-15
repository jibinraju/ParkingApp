//
//  LocationManagerHandler.swift
//  Parking
//
//  Created by Jibin Raju on 15/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import CoreLocation

class LocationManagerHandler: NSObject {
    // MARK: - Properties
    private var locationManager: CLLocationManager
    private weak var delegate: LocationManagerHandlerDelegate?
    
    // MARK: - Accessors
    init(delegate: LocationManagerHandlerDelegate? = nil) {
        locationManager = CLLocationManager()
        self.delegate = delegate
        super.init()
        locationManager.delegate = self
        requestLocation()
    }
    
    func requestLocation()  {
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined || status == .denied  {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        if !CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
}

extension LocationManagerHandler: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
        
        if (delegate?.responds(to: #selector(LocationManagerHandlerDelegate.locationManagerHandler(_:didChangeAuthorization:))))! {
            delegate?.locationManagerHandler!(self, didChangeAuthorization: status)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            if (delegate?.responds(to: #selector(LocationManagerHandlerDelegate.locationManagerHandler(_:didUpdateLocation:))))! {
                delegate?.locationManagerHandler!(self, didUpdateLocation: location)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if (delegate?.responds(to: #selector(LocationManagerHandlerDelegate.locationManagerHandler(_:didFailWithError:))))! {
            delegate?.locationManagerHandler!(self, didFailWithError: error)
        }
    }
}

@objc protocol LocationManagerHandlerDelegate: NSObjectProtocol {
    @objc optional func locationManagerHandler(_ locationManagerHandler: LocationManagerHandler, didChangeAuthorization status: CLAuthorizationStatus)
    @objc optional func locationManagerHandler(_ locationManagerHandler: LocationManagerHandler, didUpdateLocation location: CLLocation)
    @objc optional func locationManagerHandler(_ locationManagerHandler: LocationManagerHandler, didFailWithError error: Error)
}
