//
//  ParkingZone.swift
//  Parking
//
//  Created by Jibin Raju on 15/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import CoreLocation

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
        static let Name = "name"
    }

    // MARK: - Accessors
    init(parkingZoneData: Dictionary<String, Dictionary<String, Any>>) {
        let keys = parkingZoneData.keys
        zoneID = keys.first
        let values = parkingZoneData[zoneID]
        address = values![Keys.Address] as? String
        latitude = values![Keys.Latitude] as? Double
        longitude = values![Keys.Longitude] as? Double
        tariff = values![Keys.Tariff] as? String
    }
    
    init(address: String, latitude: Double, longitude: Double, tariff: String, zoneID: String? = nil) {
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.tariff = tariff
        self.zoneID = zoneID
    }
    
    public var locationCoordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    public var prettyTariff: String {
        return String(format: "%@ : %@", Keys.Tariff.uppercased(), tariff)
    }
}
