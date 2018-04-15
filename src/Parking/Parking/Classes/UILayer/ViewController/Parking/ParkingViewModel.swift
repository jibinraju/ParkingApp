//
//  ParkingViewModel.swift
//  Parking
//
//  Created by Jibin Raju on 15/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import Foundation

class ParkingViewModel {
    // MARK: - Properties
    let title: String
    let selectedZoneText: String
    let vehicleText: String
    let dataLoadingMessage: String
    let failedToRetrieveZones: String
    let mapAnnotationReuseIdentifier: String
    let startParkingButtonText: String
    let stopParkingButtonText: String
    let failedToRetrieveVehicles: String
    let userHaveNoVehicleErrorMessage: String

    // MARK: - Accessors
    init() {
        title = NSLocalizedString("Parking_Screen_Title", comment: "Parking Screen title")
        selectedZoneText = NSLocalizedString("Parking_Selected_Zone_Text", comment: "Selected zone for parking")
        vehicleText = NSLocalizedString("Parking_Vehicel_Name_Text", comment: "Vehicel name text")
        dataLoadingMessage = NSLocalizedString("Loading", comment: "Data loading message")
        failedToRetrieveZones = NSLocalizedString("Failed_Retrieve_Parking_Zones", comment: "Failed to retrieve parking zones")
        mapAnnotationReuseIdentifier = "ParkingZoneAnnotationIdentifier"
        startParkingButtonText = NSLocalizedString("Start_Parking_Button_Text", comment: "Start parking button text")
        stopParkingButtonText = NSLocalizedString("Stop_Parking_Button_Text", comment: "Stop parking button text")
        failedToRetrieveVehicles = NSLocalizedString("Failed_Retrieve_Vehicles", comment: "Failed to retrieve vehicles")
        userHaveNoVehicleErrorMessage = NSLocalizedString("User_Have_No_Vehicle", comment: "No vehicle error text")
    }
}
