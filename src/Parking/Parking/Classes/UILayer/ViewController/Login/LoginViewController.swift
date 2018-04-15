//
//  LoginViewController.swift
//  Parking
//
//  Created by Jibin Raju on 11/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: - Properties
    private var viewModel: LoginViewModel!
    private var viewDataSource: LoginDataSource!
    private var userListService: UsersService!
    private var needToRequestData: Bool = true
    private var deleteUserService: DeleteUserService!
    
    private var loadingAlertController: UIAlertController!
    
    @IBOutlet weak private var addNewUser: UIButton!
    @IBOutlet weak private var userListTableView: UITableView!
    
    // MARK: - Accessors
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        userListTableView.register(UITableViewCell.self, forCellReuseIdentifier: viewModel.cellReuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if needToRequestData {
            needToRequestData = false
            fetchUserList()
        }
    }
    
    @IBAction func onTouchUpNewUserButton(_ sender: UIButton) {
        let newUserViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewUserVC") as! NewUserViewController
        newUserViewController.delegate = self
        self.navigationController?.pushViewController(newUserViewController, animated: true)
    }
    
    // MARK: - Private Accessors
    private func setupViewModel() {
        viewModel = LoginViewModel.init()
        
        title = viewModel.title
        addNewUser.setTitle(viewModel.newUserButtonTitle, for: UIControlState.normal)
    }
    
    private func setupDataSource(users: Array<User>) {
        viewDataSource = LoginDataSource.init(reuseCellIdentifier: viewModel.cellReuseIdentifier, dataSource: users, self)

        userListTableView.dataSource = viewDataSource
        userListTableView.delegate = viewDataSource
        userListTableView.reloadData()
    }
    
    private func fetchUserList() {
        loadingAlertController = showLoadingAlert(loadingMessage: viewModel.dataLoadingMessage)
        userListService = UsersService()
        userListService.fetch { (users, error) in
            self.loadingAlertController.dismiss(animated: true, completion: nil)
            if error != nil {
                self.showMessageAlert(message: self.viewModel.localizedUserListErrorMessage)
                return
            }
            
            self.setupDataSource(users: (users as? Array<User>)!)
        }
    }
}

// MARK: - LoginDataSourceDelegate
extension LoginViewController: LoginDataSourceDelegate {
    func didSelectUser(loginDataSource: LoginDataSource, selectedUser: User) {
        let parkingViewController = self.storyboard?.instantiateViewController(withIdentifier: "ParkingVC") as! ParkingViewController
        parkingViewController.selectedUser = selectedUser
        self.present(parkingViewController, animated: true, completion: nil)
    }
    
    func didDeleteUser(loginDataSource: LoginDataSource, deleteUser: User) {
        if deleteUser.userID.isEmpty {
            showMessageAlert(message: viewModel.invalidUserIdErrorMessage)
            return
        }
        
        deleteUserService = DeleteUserService();
        deleteUserService.deleteUser(user: deleteUser) { (response, error) in
         if error != nil {
             self.showMessageAlert(message: self.viewModel.failedToDeleteUserErrorMessage)
                return
             }
            
             self.fetchUserList()
         }
    }
}

// MARK: - LoginDataSourceDelegate
extension LoginViewController: NewUserViewControllerDelegate {
    func didCreateNewUser(newUserViewController: NewUserViewController, newUserID: String) {
        needToRequestData = true
    }
}

