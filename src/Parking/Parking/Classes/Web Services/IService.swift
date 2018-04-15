//
//  IService.swift
//  Parking
//
//  Created by Jibin Raju on 12/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

protocol IService {
    var requestURL: String! {get}
    var httpHeaderFields: Dictionary<String, String>! {get}
    var bodyParameters: Dictionary<String, String>! {get}
    var methodType: String! {get}
    var responseProcessor: IResponseProcessor? {get}
}
