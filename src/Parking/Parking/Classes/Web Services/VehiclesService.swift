//
//  VehiclesService.swift
//  Parking
//
//  Created by Jibin Raju on 15/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import Foundation

class VehiclesService: Service {
    override var requestURL: String! {
        return super.requestURL! + Constants.HTTP.Url.VehiclesPath
    }
    
    func fetch(completionCallBack: @escaping CompletionCallBack) {
        responseProcessor = VehiclesResponseProcessor(completionCallBack: completionCallBack)
        ServiceQueue.shared().addOperation(self)
    }
}
