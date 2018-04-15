//
//  UIViewController+Convenient.swift
//  Parking
//
//  Created by Jibin Raju on 14/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showMessageAlert(message: String, okCallBack: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alertViewController = UIAlertController.alertWithOKButton(message: message, okActionCallBack: okCallBack)
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    func showLoadingAlert(loadingMessage: String) -> UIAlertController {
        let alertViewController = UIAlertController.loadingAlert(loadingMessage)
        self.present(alertViewController, animated: true, completion: nil)
        
        return alertViewController
    }
}
