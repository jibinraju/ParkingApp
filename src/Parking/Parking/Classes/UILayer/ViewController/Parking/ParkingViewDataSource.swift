//
//  ParkingViewDataSource.swift
//  Parking
//
//  Created by Jibin Raju on 15/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import MapKit

class ParkingViewDataSource : NSObject, MKMapViewDelegate {
    // MARK: - Properties
    let zones: Array<String>
    
    // MARK: - Accessors
    init(zones: Array<String>) {
        self.zones = zones
    }
}
