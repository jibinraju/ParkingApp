//
//  LoginViewModelTests.swift
//  ParkingTests
//
//  Created by Jibin Raju on 15/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import XCTest
@testable import Parking

class LoginViewModelTests: XCTestCase {
    var loginViewModel: LoginViewModel!
    
    override func setUp() {
        super.setUp()
        loginViewModel = LoginViewModel()
    }
    
    func testShouldHaveTitle() {
        let title = NSLocalizedString("User_Screen_Title", comment: "")
        XCTAssertEqual(loginViewModel.title, title)
    }
    
    func testShouldHaveTableViewCellReuseIdentifier() {
        let cellReuseIdentifier = "LoginCellIdentifier"
        XCTAssertEqual(cellReuseIdentifier, loginViewModel.cellReuseIdentifier)
    }
    
    func testShouldHaveNewUserButtonTitle() {
        let newUserButtonTitle = NSLocalizedString("New_User_Button_Title", comment: "")
        XCTAssertEqual(loginViewModel.newUserButtonTitle, newUserButtonTitle)
    }
    
    func testShouldHaveLocalizedUserListErrorMessage() {
        let localizedUserListErrorMessage = NSLocalizedString("User_List_Error", comment: "")
        XCTAssertEqual(loginViewModel.localizedUserListErrorMessage, localizedUserListErrorMessage)
    }
    
    func testShouldHaveDataLoadingMessage() {
        let dataLoadingMessage = NSLocalizedString("Loading", comment: "")
        XCTAssertEqual(loginViewModel.dataLoadingMessage, dataLoadingMessage)
    }
    
    func testShouldHaveInvalidUserIdErrorMessage() {
        let invalidUserIdErrorMessage = NSLocalizedString("Unable_To_Delete", comment: "")
        XCTAssertEqual(loginViewModel.invalidUserIdErrorMessage, invalidUserIdErrorMessage)
    }
    
    func testShouldHaveFailedToDeleteUserErrorMessage() {
        let failedToDeleteUserErrorMessage = NSLocalizedString("Failed_Delete_User", comment: "")
        XCTAssertEqual(loginViewModel.failedToDeleteUserErrorMessage, failedToDeleteUserErrorMessage)
    }
}
