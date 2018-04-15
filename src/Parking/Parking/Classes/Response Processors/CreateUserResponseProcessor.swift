//
//  CreateNewUserResponseProcessor.swift
//  Parking
//
//  Created by Jibin Raju on 14/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import Foundation

class CreateUserResponseProcessor: ResponseProcessor {
    override func processResponse(response: Any) {
        guard let newUserInformation = response as? Dictionary<String, String> else {
            let error = NSError.init(domain: Constants.Errors.Domain.Name, code: Constants.Errors.Code.InValidObject)
            completionCallBack?(nil, error)
            return
        }
        
        let newUserID = newUserInformation[User.Keys.Name]
        if (newUserID?.isEmpty)! {
            let error = NSError.init(domain: Constants.Errors.Domain.Name, code: Constants.Errors.Code.InValidObject)
            completionCallBack?(nil, error)
            return
        }
        super.processResponse(response: newUserID!)
    }
}
