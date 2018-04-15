//
//  Constants.swift
//  Parking
//
//  Created by Jibin Raju on 12/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

struct Constants {
    
    static let OperationQueueName = "com.parkingmobile.WebServiceQueue"
    
    struct Errors {
        struct Domain {
            static let Name = "ParkMobile"
        }
        
        struct Code {
            static let InValidObject = 100001
        }
    }
    
    struct  HTTP {
        
        static let RequestTimeOut = 300.0
        
        struct Url {
            static let BasePath = "https://testapi-11cc3-657ec.firebaseio.com/"
            static let UsersPath = "users.json"
            static let UserDeletePath = "users/%@.json"
            static let ParkingZonesPath = "parkingZones.json"
            static let VehiclesPath = "vehicles.json"
        }
        
        struct HeaderKey {
            static let Accept = "Accept"
            static let ContentType = "Content-Type"
            static let MethodOverride = "X-HTTP-Method-Override"
        }
        
        struct HeaderValue {
            static let ApplicationJSON = "application/json"
        }
        
        struct MethodType {
            static let GET = "GET"
            static let POST = "POST"
            static let DELETE = "DELETE"
        }
    }
}
