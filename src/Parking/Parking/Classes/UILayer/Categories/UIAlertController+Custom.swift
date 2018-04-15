//
//  UIAlertController+Custom.swift
//  Parking
//
//  Created by Jibin Raju on 13/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    class func alertWithOKButton(message: String, okActionCallBack: ((UIAlertAction) -> Swift.Void)? = nil) -> UIAlertController {
        let title = NSLocalizedString("App_Name", comment: "Alert viewcontroller title")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButtonTitle = NSLocalizedString("OK", comment: "OK buttone title")
        let OKAction = UIAlertAction(title: okButtonTitle, style: .default, handler: okActionCallBack)
        alertController.addAction(OKAction)
        
        return alertController
    }
    
    class func loadingAlert(_ message: String? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        alertController.view.addSubview(loadingIndicator)
        
        return alertController
    }
}
