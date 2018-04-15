//
//  UsersResponseProcessor.swift
//  Parking
//
//  Created by Jibin Raju on 13/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import Foundation

class UsersResponseProcessor: ResponseProcessor {

    override func processResponse(response: Any) {
        guard let userList = response as? Dictionary<String, Dictionary<String, String>> else {
            let error = NSError.init(domain: Constants.Errors.Domain.Name, code: Constants.Errors.Code.InValidObject)
            completionCallBack?(nil, error)
            return
        }
        
        var users = Array<User>.init()
        for (key, value) in userList {
            let user = User.init(data: [key: value])
            users.append(user)
        }
        super.processResponse(response: users)
    }
    
}
