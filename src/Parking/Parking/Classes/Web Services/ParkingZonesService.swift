//
//  ParkingZonesService.swift
//  Parking
//
//  Created by Jibin Raju on 15/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit

class ParkingZonesService: Service {

    override var requestURL: String! {
        return super.requestURL! + Constants.HTTP.Url.ParkingZonesPath
    }
    
    func fetch(completionCallBack: @escaping CompletionCallBack) {
        responseProcessor = ParkingZonesResponseProcessor(completionCallBack: completionCallBack)
        ServiceQueue.shared().addOperation(self)
    }
}
