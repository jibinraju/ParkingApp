//
//  ParkingZoneAnnotation.swift
//  Parking
//
//  Created by Jibin Raju on 15/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import MapKit

class ParkingZoneAnnotation: MKPointAnnotation {
    private var _parkingZone: ParkingZone?? = nil
    
    public var parkingZone: ParkingZone? {
        get {
            return _parkingZone!
        }
        
        set(newParkingZone) {
            _parkingZone = newParkingZone!
            coordinate = (newParkingZone?.locationCoordinates)!
            title = newParkingZone?.address
            subtitle = newParkingZone?.prettyTariff
        }
    }
}
