//
//  NewUserViewController.swift
//  Parking
//
//  Created by Jibin Raju on 14/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit

class NewUserViewController: UIViewController {
    // MARK: - Properties
    private var viewModel: NewUserViewModel!
    private var createUserService: CreateUserService!
    private var user: User!
    public weak var delegate: NewUserViewControllerDelegate?
    
    private var loadingAlertController: UIAlertController!
    
    @IBOutlet weak private var firstNameLable: UILabel!
    @IBOutlet weak private var lastNameLabel: UILabel!
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var firstNameText: UITextField!
    @IBOutlet weak private var lastNameText: UITextField!
    @IBOutlet weak private var userNameText: UITextField!
    @IBOutlet weak private var createUserButton: UIButton!
    
    // MARK: - Accessors
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewModel()
    }
    @IBAction func onTouchCreateNewUser(_ sender: UIButton) {
        if !prepareNewUserInformation() {
            return
        }
        
        loadingAlertController = showLoadingAlert(loadingMessage: viewModel.creatingNewUserWaitingMessage)
        createUserService = CreateUserService()
        createUserService.createNewUser(user: user) { (newUserID, error) in
            self.loadingAlertController.dismiss(animated: false, completion: nil)
            if error != nil {
                self.showMessageAlert(message: self.viewModel.failedCreateNewUser)
                return
            }
            
            let deadlineTime = DispatchTime.now() + .milliseconds(80)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                self.delegate?.didCreateNewUser(newUserViewController: self, newUserID: newUserID as! String)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    // MARK: - Private Accessors
    private func setupViewModel() {
        viewModel = NewUserViewModel()
        
        title = viewModel.title
        firstNameLable.text = viewModel.firstNameLabelText
        firstNameText.placeholder = viewModel.firsNameTextPlaceHolder
        lastNameLabel.text = viewModel.lastNameLableText
        lastNameText.placeholder = viewModel.lastNameTextPlaceHolder
        userNameLabel.text = viewModel.userNameLabelText
        userNameText.placeholder = viewModel.userNameTextPlaceHolder
        createUserButton.setTitle(viewModel.createNewUserButtonText, for: UIControlState.normal)
    }
    
    private func showErrorMessageForEmptyTextField(_ textField: UITextField) -> Bool {
        if (textField.text?.isEmpty)! {
            showMessageAlert(message: viewModel.emptyTextFieldWaringMessage) { (action) in
                textField.becomeFirstResponder()
            }
            return true
        }
        
        return false
    }
    
    private func prepareNewUserInformation() -> Bool {
        if showErrorMessageForEmptyTextField(firstNameText) {
            return false
        }
        
        if showErrorMessageForEmptyTextField(lastNameText) {
            return false
        }
        
        if showErrorMessageForEmptyTextField(userNameText) {
            return false
        }
        
        user = User(firstName: firstNameText.text!, lastName: lastNameText.text!, userName: userNameText.text!)
        return true
    }
}

protocol NewUserViewControllerDelegate: NSObjectProtocol {
    func didCreateNewUser(newUserViewController: NewUserViewController, newUserID: String)
}
