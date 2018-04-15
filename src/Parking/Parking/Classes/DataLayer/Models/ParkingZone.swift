//
//  ParkingZone.swift
//  Parking
//
//  Created by Jibin Raju on 15/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import Foundation

class ParkingZone {
    // MARK: - Properties
    public private(set) var address: String!
    public private(set) var tariff: String!
    public private(set) var zoneID: String!
    public private(set) var latitude: Double!
    public private(set) var longitude: Double!
    
    private struct Keys {
        static let Address = "address"
        static let Latitude = "lat"
        static let Longitude = "lon"
        static let Tariff = "tariff"
        static let Zone = "zone"
    }

    // MARK: - Accessors
    init() {
        
    }
}
