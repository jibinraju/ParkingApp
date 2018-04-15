//
//  ParkingViewController.swift
//  Parking
//
//  Created by Jibin Raju on 15/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit
import MapKit

class ParkingViewController: UIViewController {
    // MARK: - Properties
    private var viewModel: ParkingViewModel!
    private var viewDataSource: ParkingViewDataSource!
    public var selectedUser: User!

    private var locationManagerHandler: LocationManagerHandler!
    
    @IBOutlet weak var parkingZonesMap: MKMapView!
    @IBOutlet weak var selectedZoneTextLable: UILabel!
    @IBOutlet weak var selectedZoneLabel: UILabel!
    @IBOutlet weak var vehicleTextLabel: UILabel!
    @IBOutlet weak var vehicleLabel: UILabel!
    
    // MARK: - Accessors
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        locationManagerHandler = LocationManagerHandler(delegate: self)
        setupMapView()
    }

    // MARK: - Private Accessors
    private func setupViewModel() {
        viewModel = ParkingViewModel()
        
        title = viewModel.title
        selectedZoneTextLable.text = viewModel.selectedZoneText
        vehicleTextLabel.text = viewModel.vehicleText
    }
    
    private func setupMapView() {
        parkingZonesMap.mapType = .standard
        parkingZonesMap.showsUserLocation = true
        parkingZonesMap.showsScale = true
        parkingZonesMap.showsCompass = true
    }
    
    private func setupDataSource(locations: Array<User>) {
        viewDataSource = ParkingViewDataSource(zones: [])
        parkingZonesMap.delegate = viewDataSource
    }
}

// MARK: - LocationManagerHandlerDelegate
extension ParkingViewController: LocationManagerHandlerDelegate {
    func locationManagerHandler(_ locationManagerHandler: LocationManagerHandler, didUpdateLocation location: CLLocation) {
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        parkingZonesMap.setRegion(region, animated: true)
    }
}
