//
//  VehiclesResponseProcessor.swift
//  Parking
//
//  Created by Jibin Raju on 15/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import Foundation

class VehiclesResponseProcessor: ResponseProcessor {
    override func processResponse(response: Any) {
        guard let VehiclesData = response as? Dictionary<String, Dictionary<String, Any>> else {
            let error = NSError.init(domain: Constants.Errors.Domain.Name, code: Constants.Errors.Code.InValidObject)
            completionCallBack?(nil, error)
            return
        }
        
        var vehicles = Array<Vehicle>()
        for (key, value) in VehiclesData {
            let vehicle = Vehicle(VehicleData: [key: value])
            vehicles.append(vehicle)
        }
        super.processResponse(response: vehicles)
    }
}
