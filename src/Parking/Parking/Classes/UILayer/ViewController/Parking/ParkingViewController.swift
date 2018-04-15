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
    private var parkingZonesService: ParkingZonesService!
    private var vehiclesService: VehiclesService!

    private var locationManagerHandler: LocationManagerHandler!
    private var loadingAlertController: UIAlertController!
    private var vehicles: Array<Vehicle>!
    
    @IBOutlet weak private var parkingZonesMap: MKMapView!
    @IBOutlet weak private var selectedZoneTextLable: UILabel!
    @IBOutlet weak private var selectedZoneLabel: UILabel!
    @IBOutlet weak private var vehicleTextLabel: UILabel!
    @IBOutlet weak private var vehicleLabel: UILabel!
    @IBOutlet weak private var startStopParkingButton: UIButton!
    
    // MARK: - Accessors
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        locationManagerHandler = LocationManagerHandler(delegate: self)
        setupMapView()
        fetchVehicles()
        fetchParkingZones()
        showSelectedZoneInformation(hide: true)
    }

    // MARK: - Private Accessors
    @IBAction private func onTouchStartStop(_ sender: UIButton) {
        
    }
    
    private func setupViewModel() {
        viewModel = ParkingViewModel()
        
        title = viewModel.title
        selectedZoneTextLable.text = viewModel.selectedZoneText
        vehicleTextLabel.text = viewModel.vehicleText
        startStopParkingButton.setTitle(viewModel.startParkingButtonText, for: .normal)
    }
    
    private func setupMapView() {
        parkingZonesMap.mapType = .standard
        parkingZonesMap.showsUserLocation = true
        parkingZonesMap.showsScale = true
        parkingZonesMap.showsCompass = true
    }
    
    private func showSelectedZoneInformation(hide: Bool, selectedParkingZone: ParkingZone? = nil, defaultVehicle: Vehicle? = nil) {
        selectedZoneTextLable.isHidden = hide
        selectedZoneLabel.isHidden = hide
        vehicleTextLabel.isHidden = hide
        vehicleLabel.isHidden = hide
        startStopParkingButton.isHidden = hide
        
        if selectedParkingZone != nil {
            selectedZoneLabel.text = selectedParkingZone?.address
        }
        
        if defaultVehicle != nil {
            vehicleLabel.text = defaultVehicle?.title
        }
    }
    
    private func setupDataSource(parkingZones: Array<ParkingZone>) {
        viewDataSource = ParkingViewDataSource(mapAnnotationReuseIdentifier: viewModel.mapAnnotationReuseIdentifier, zones: parkingZones, delegate: self)
        parkingZonesMap.delegate = viewDataSource
        parkingZonesMap.addAnnotations(viewDataSource.mapAnnotations())
    }
    
    private func fetchParkingZones() {
        loadingAlertController = showLoadingAlert(loadingMessage: viewModel.dataLoadingMessage)
        parkingZonesService = ParkingZonesService()
        parkingZonesService.fetch { (parkingZones, error) in
            self.loadingAlertController.dismiss(animated: true, completion: nil)
            if error != nil {
                self.showMessageAlert(message: self.viewModel.failedToRetrieveZones)
                return
            }
            self.setupDataSource(parkingZones: (parkingZones as? Array<ParkingZone>)!)
        }
    }
    
    private func fetchVehicles() {
        vehiclesService = VehiclesService()
        vehiclesService.fetch { (vehicles, error) in
            if error != nil {
                self.showMessageAlert(message: self.viewModel.failedToRetrieveVehicles)
                return
            }
            
            self.vehicles = vehicles as? Array<Vehicle>
        }
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

//MARK: - ParkingViewDataSourceDelegate
extension ParkingViewController: ParkingViewDataSourceDelegate {
    func parkingViewDataSource(_ parkingViewDataSource: ParkingViewDataSource, didSelectedParkingZone parkingZone: ParkingZone) {
        let userOwnVehicels = vehicles.findVehicles(associatedWithUserID: selectedUser.userID)
        if userOwnVehicels.isEmpty {
            showMessageAlert(message: viewModel.userHaveNoVehicleErrorMessage)
            return
        }
        
        let defaultVehicle = userOwnVehicels.defaultVehicle()
        showSelectedZoneInformation(hide: false, selectedParkingZone: parkingZone, defaultVehicle: defaultVehicle)
    }
}
