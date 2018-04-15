//
//  Array+Convenient.swift
//  Parking
//
//  Created by Jibin Raju on 15/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import Foundation

extension Array where Element:Vehicle  {
    func findVehicles(associatedWithUserID userID: String) -> Array<Vehicle> {
        var result = Array<Vehicle>()
        for vehicle in self {
            if vehicle.userID == userID {
                result.append(vehicle)
            }
        }
        return result
    }
    
    func defaultVehicle() -> Vehicle? {
        var defaultVehicle: Vehicle? = first
        for vehicle in self {
            if vehicle.isDefault {
                defaultVehicle =  vehicle
                break
            }
        }
        return defaultVehicle
    }
}
