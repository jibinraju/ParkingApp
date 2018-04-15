//
//  IResponseProcessor.swift
//  Parking
//
//  Created by Jibin Raju on 12/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import Foundation

protocol IResponseProcessor {
    var receviedData: Data! {get}
    var receviedDataLenght: Int {get}
    var completionCallBack: CompletionCallBack? {get}
    
    func didReceiveData(data: Data)
    func didFinishReceivingData()
    func didFailRecevingData(error: Error)
}
