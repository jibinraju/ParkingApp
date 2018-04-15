//
//  DeleteUserService.swift
//  Parking
//
//  Created by Jibin Raju on 14/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import Foundation

class DeleteUserService: Service {
    private var user: User!
    
    override var requestURL: String! {
        let requestURL = String(format: Constants.HTTP.Url.UserDeletePath, user.userID)
        return super.requestURL! + requestURL
    }
    
    override var methodType: String! {
        return Constants.HTTP.MethodType.DELETE
    }
    
    func deleteUser(user: User, completionCallBack: @escaping CompletionCallBack) {
        self.user = user
        responseProcessor = DeleteUserResponseProcessor(completionCallBack: completionCallBack)
        ServiceQueue.shared().addOperation(self)
    }
    
}
