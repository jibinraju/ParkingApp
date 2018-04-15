//
//  DeleteUserResponseProcessor.swift
//  Parking
//
//  Created by Jibin Raju on 14/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import Foundation

class DeleteUserResponseProcessor: ResponseProcessor {
    override func didFinishReceivingData() {
        if receviedDataLenght == 0 {
            let error = NSError.init(domain: Constants.Errors.Domain.Name, code: Constants.Errors.Code.InValidObject)
            completionCallBack?(nil, error)
            return
        }
        
        let response = String.init(data: receviedData, encoding: .utf8)
        if (response?.isEmpty)! {
            let error = NSError.init(domain: Constants.Errors.Domain.Name, code: Constants.Errors.Code.InValidObject)
            completionCallBack?(nil, error)
            return
        }
        processResponse(response: response!)
    }
}
