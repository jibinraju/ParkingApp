//
//  ParkingZonesResponseProcessor.swift
//  Parking
//
//  Created by Jibin Raju on 15/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit

class ParkingZonesResponseProcessor: ResponseProcessor {
    override func processResponse(response: Any) {
        guard let userList = response as? Dictionary<String, Dictionary<String, Any>> else {
            let error = NSError.init(domain: Constants.Errors.Domain.Name, code: Constants.Errors.Code.InValidObject)
            completionCallBack?(nil, error)
            return
        }
        
        var parkingZones = Array<ParkingZone>()
        for (key, value) in userList {
            let parkingZone = ParkingZone(parkingZoneData: [key: value])
            parkingZones.append(parkingZone)
        }
        super.processResponse(response: parkingZones)
    }
}
