//
//  CreateUserService.swift
//  Parking
//
//  Created by Jibin Raju on 14/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import Foundation

class CreateUserService: Service {
    private var user: User!
    
    override var requestURL: String! {
        return super.requestURL! + Constants.HTTP.Url.UsersPath
    }
    
    override var methodType: String! {
        return Constants.HTTP.MethodType.POST
    }
    
    override var bodyParameters: Dictionary<String, String>! {
        var bodyParams =  Dictionary<String, String>()
        if user != nil {
            bodyParams[User.Keys.FirstName] = user.firstName
            bodyParams[User.Keys.LastName] = user.lastName
            bodyParams[User.Keys.UserName] = user.userName
        }
        return bodyParams
    }
    
    func createNewUser(user: User, completionCallBack: @escaping CompletionCallBack) {
        self.user = user
        responseProcessor = CreateUserResponseProcessor(completionCallBack: completionCallBack)
        ServiceQueue.shared().addOperation(self)
    }
    
}
