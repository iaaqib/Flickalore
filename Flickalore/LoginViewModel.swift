//
//  LoginViewModel.swift
//  Flickalore
//
//  Created by Aaqib Hussain on 28/7/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import UIKit
import FlickrKit

class LoginViewModel: NSObject {

    private let flickrKit: FlickrKit
    
    var isLoggedIn: ()->() = {}
    
    init(flickrKit: FlickrKit = FlickrKit.shared()) {
        self.flickrKit = flickrKit
    }
    
    func isUserLoggedIn() {
        if UserManager.shared.isUserLoggedIn {
         checkAuthorization()
        }
    }
    
    private func checkAuthorization() {
    FlickrKit.shared().checkAuthorization { (userName, userId, fullName, error) -> Void in
            DispatchQueue.main.async(execute: { [weak self] () -> Void in
                guard let `self` = self else { return }
                if let error = error {
                    
                } else {
                    let user = UserManager.shared.getLoggedInUser()!
                    let authenticatedUser =  User(userName: userName ?? "NA", name: fullName ?? "NA", userId: userId ?? "NA", accessToken: user.accessToken)
                    UserManager.shared.setUser(user: authenticatedUser)
                    self.isLoggedIn()
                }
            })
        }
    }
}
