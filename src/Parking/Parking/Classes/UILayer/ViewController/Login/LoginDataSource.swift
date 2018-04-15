//
//  LoginDataSource.swift
//  Parking
//
//  Created by Jibin Raju on 13/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit

class LoginDataSource : NSObject, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Properties
    private var dataSource: Array<User>
    private var reuseCellIdentifier: String
    private weak var delegate: LoginDataSourceDelegate?
    
    init(reuseCellIdentifier: String, dataSource: Array<User>, _ delegate: LoginDataSourceDelegate?) {
        self.dataSource = dataSource
        self.reuseCellIdentifier = reuseCellIdentifier
        self.delegate = delegate!
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: reuseCellIdentifier) as UITableViewCell?)!
        let user = dataSource[indexPath.row] as User
        cell.textLabel?.text = user.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = dataSource[indexPath.row]
        if delegate != nil {
            delegate?.didSelectUser(loginDataSource: self, selectedUser: user)
        }
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    // MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let user = dataSource[indexPath.row]
        if delegate != nil {
            delegate?.didDeleteUser(loginDataSource: self, deleteUser: user)
        }
    }
}

// MARK: LoginDataSourceDelegate
protocol LoginDataSourceDelegate: NSObjectProtocol {
    func didSelectUser(loginDataSource: LoginDataSource, selectedUser: User)
    func didDeleteUser(loginDataSource: LoginDataSource, deleteUser: User)
}

