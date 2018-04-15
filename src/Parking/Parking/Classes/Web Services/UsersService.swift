//
//  UsersService.swift
//  Parking
//
//  Created by Jibin Raju on 13/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import Foundation

class UsersService: Service {

    override var requestURL: String! {
        return super.requestURL! + Constants.HTTP.Url.UsersPath
    }
    
    func fetch(completionCallBack: @escaping CompletionCallBack) {
        responseProcessor = UsersResponseProcessor(completionCallBack: completionCallBack)
        ServiceQueue.shared().addOperation(self)
    }
        
}
