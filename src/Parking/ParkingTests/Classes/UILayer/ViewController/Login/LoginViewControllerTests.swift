//
//  ParkingTests.swift
//  ParkingTests
//
//  Created by Jibin Raju on 11/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import XCTest
@testable import Parking

class LoginViewControllerTests: XCTestCase {
    var loginViewController: LoginViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: LoginViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
        loginViewController = vc
        _ = loginViewController.view
    }
    
    func testShouldHaveTitle() {
        XCTAssertNotNil(loginViewController.title)
    }

}
