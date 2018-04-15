//
//  ResponseProcessor.swift
//  Parking
//
//  Created by Jibin Raju on 13/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import Foundation

typealias CompletionCallBack = (_ response: Any?, _ error: NSError?) -> Void

class ResponseProcessor: IResponseProcessor {
    // MARK: - Properties
    var receviedData: Data!
    var receviedDataLenght: Int {
        if receviedData.count == 0 {
            return 0
        }
        return receviedData.count
    }
    var completionCallBack: CompletionCallBack? {
        return completionCallBackHandler
    }
    private var completionCallBackHandler: CompletionCallBack?
    
    // MARK: -
    init(completionCallBack: @escaping CompletionCallBack) {
        completionCallBackHandler = completionCallBack
    }
    
    // MARK: - Accessors
    func didReceiveData(data: Data) {
        if receviedData == nil {
            receviedData = Data.init()
        }
        
        receviedData.append(data)
    }
    
    func didFinishReceivingData() {
        if receviedDataLenght == 0 {
            let error = NSError.init(domain: Constants.Errors.Domain.Name, code: Constants.Errors.Code.InValidObject)
            completionCallBack?(nil, error)
            return
        }
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: receviedData, options: JSONSerialization.ReadingOptions.mutableLeaves)
            if JSONSerialization.isValidJSONObject(jsonObject) {
                processResponse(response: jsonObject)
            }
            else {
                let error = NSError.init(domain: Constants.Errors.Domain.Name, code: Constants.Errors.Code.InValidObject)
                completionCallBack?(nil, error)
            }
        
        }
        catch let error as NSError {
            print("Failed to parse JSON data \(error)")
            completionCallBack?(nil, error as NSError)
        }
    }
    
    func didFailRecevingData(error: Error) {
        completionCallBack?(nil, error as NSError)
    }
    
    func processResponse(response: Any) {
        //override and do the process in child class
        
        // Back to UI Thread
        DispatchQueue.main.async {
            self.completionCallBack?(response, nil)
        }
    }
}
