//
//  NewUserViewModel.swift
//  Parking
//
//  Created by Jibin Raju on 14/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import Foundation

class NewUserViewModel {
    // MARK: - Properties
    let title: String
    let firstNameLabelText: String
    let lastNameLableText : String
    let userNameLabelText: String
    let firsNameTextPlaceHolder: String
    let lastNameTextPlaceHolder: String
    let userNameTextPlaceHolder: String
    let createNewUserButtonText: String
    let emptyTextFieldWaringMessage: String
    let creatingNewUserWaitingMessage: String
    let failedCreateNewUser: String
    
    // MARK: - Accessors
    init() {
        title = NSLocalizedString("NewUser_Screen_Title", comment: "New User Screen title")
        firstNameLabelText = NSLocalizedString("First_Name_Text", comment: "First name label text")
        lastNameLableText = NSLocalizedString("Last_Name_Text", comment: "Second name label text")
        userNameLabelText = NSLocalizedString("User_Name_Text", comment: "User name label text")
        firsNameTextPlaceHolder = NSLocalizedString("First_Name_Text_Placeholder", comment: "First name text place holder")
        lastNameTextPlaceHolder = NSLocalizedString("Last_Name_Text_Placeholder", comment: "Last name text place holder")
        userNameTextPlaceHolder = NSLocalizedString("User_Name_Text_Placeholder", comment: "User name text place holder")
        createNewUserButtonText = NSLocalizedString("Create_New_User", comment: "Create new user button title")
        emptyTextFieldWaringMessage = NSLocalizedString("Empty_Message_Warning", comment: "Warning message for empty text field")
        creatingNewUserWaitingMessage = NSLocalizedString("Creating_User_Process_Message", comment: "Waiting message while application request to create new user")
        failedCreateNewUser = NSLocalizedString("Failed_Create_New_User_Error_Message", comment: "Failed to create new user information to user")
    }
}
