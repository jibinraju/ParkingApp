//
//  ServiceQueue.swift
//  Parking
//
//  Created by Jibin Raju on 13/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit

class ServiceQueue: OperationQueue {
    // MARK: - Properties
    private static var sharedServiceQueue: ServiceQueue = {
        return ServiceQueue()
    }()

    private override init() {
        super.init()
        self.maxConcurrentOperationCount = ServiceQueue.defaultMaxConcurrentOperationCount
        self.name = Constants.OperationQueueName;
    }
    
    // MARK: - Accessors
    class func shared() -> OperationQueue {
        return sharedServiceQueue
    }
    
    override func cancelAllOperations() {
        super.cancelAllOperations()
        waitUntilAllOperationsAreFinished()
    }
}
