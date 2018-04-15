//
//  LoginViewModel.swift
//  Parking
//
//  Created by Jibin Raju on 13/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import Foundation

class LoginViewModel {
    // MARK: - Properties
    let title: String
    let cellReuseIdentifier: String
    let newUserButtonTitle : String
    let localizedUserListErrorMessage: String
    let dataLoadingMessage: String
    let invalidUserIdErrorMessage: String
    let failedToDeleteUserErrorMessage: String
    
    // MARK: - Accessors
    init() {
        title = NSLocalizedString("User_Screen_Title", comment: "Login Screen title")
        cellReuseIdentifier = "LoginCellIdentifier"
        newUserButtonTitle = NSLocalizedString("New_User_Button_Title", comment: "new user button title")
        localizedUserListErrorMessage = NSLocalizedString("User_List_Error", comment: "failed retrive user list")
        dataLoadingMessage = NSLocalizedString("Loading", comment: "Data loading message")
        invalidUserIdErrorMessage = NSLocalizedString("Unable_To_Delete", comment: "Invalid userid, user cannot delete")
        failedToDeleteUserErrorMessage = NSLocalizedString("Failed_Delete_User", comment: "Failed to delete user from server")
    }
}
