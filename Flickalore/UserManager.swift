//
//  UserManager.swift
//  Flickalore
//
//  Created by Aaqib Hussain on 28/7/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import UIKit

class UserManager: NSObject {

    static let shared = UserManager()
    
    private let userDefaults = UserDefaults.standard
    
    private override init() { }
    
    var isUserLoggedIn: Bool {
        return getLoggedInUser() != nil
    }
    
    func setUser(user: User) {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: user)
        userDefaults.set(encodedData, forKey: User.className)
    }
    
    func getLoggedInUser() -> User? {
        guard let data = userDefaults.value(forKey: User.className) as? Data else { return nil }
        let loggedInUser = NSKeyedUnarchiver.unarchiveObject(with: data) as? User
        return loggedInUser
    }
    
    
}
