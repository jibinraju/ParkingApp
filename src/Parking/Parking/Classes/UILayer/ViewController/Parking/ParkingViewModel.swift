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

    // MARK: - Accessors
    init() {
        title = NSLocalizedString("Parking_Screen_Title", comment: "Parking Screen title")
        selectedZoneText = NSLocalizedString("Parking_Selected_Zone_Text", comment: "Selected zone for parking")
        vehicleText = NSLocalizedString("Parking_Vehicel_Name_Text", comment: "Vehicel name text")
    }
}
