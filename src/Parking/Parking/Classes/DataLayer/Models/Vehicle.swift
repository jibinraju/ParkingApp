//
//  Vehicle.swift
//  Parking
//
//  Created by Jibin Raju on 15/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import Foundation

class Vehicle {
    // MARK: - Properties
    public private(set) var title: String!
    public private(set) var isDefault: Bool!
    public private(set) var vehicleID: String!
    public private(set) var userID: String!
    public private(set) var vehicleRegistrationNumber: String!

    private struct Keys {
        static let IsDefault = "isDefault"
        static let Title = "title"
        static let UserID = "userId"
        static let VehicleRegistrationNumber = "vrn"
        static let Name = "name"
    }
    
    // MARK: - Accessors
    init(VehicleData: Dictionary<String, Dictionary<String, Any>>) {
        let keys = VehicleData.keys
        vehicleID = keys.first
        let values = VehicleData[vehicleID]
        title = values![Keys.Title] as? String
        isDefault = values![Keys.IsDefault] as? Bool
        userID = values![Keys.UserID] as? String
        vehicleRegistrationNumber = values![Keys.VehicleRegistrationNumber] as? String
    }
    
    init(title: String, isDefault: Bool, userID: String, vehicleRegistrationNumber: String, vehicleID: String? = nil) {
        self.title = title
        self.isDefault = isDefault
        self.userID = userID
        self.vehicleRegistrationNumber = vehicleRegistrationNumber
        self.vehicleID = vehicleID
    }
}

