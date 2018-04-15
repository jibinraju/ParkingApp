//
//  User.swift
//  Parking
//
//  Created by Jibin Raju on 13/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit

class User {
    // MARK: - Properties
    public private(set) var firstName: String!
    public private(set) var lastName: String!
    public private(set) var userName: String!
    public private(set) var userID: String!
    
    public struct Keys {
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let UserName = "userName"
        static let Name = "name"
    }
    
    // MARK: - Accessors
    init(data: Dictionary<String, Dictionary<String, String>>) {
        let keys = data.keys
        userID = keys.first
        let values = data[userID]
        firstName = values![Keys.FirstName]
        lastName = values![Keys.LastName]
        userName = values![Keys.UserName]
    }
    
    init(firstName: String, lastName: String, userName: String, userID: String? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.userName = userName
        self.userID = userID
    }
    
    public var name: String? {
        var resultName = userName
        if (userName == nil && firstName != nil && lastName != nil) {
            resultName = firstName + lastName
        }
        return resultName ?? ""
    }
}
