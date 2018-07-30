//
//  AuthViewModel.swift
//  Flickalore
//
//  Created by Aaqib Hussain on 28/7/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import UIKit
import FlickrKit

class AuthViewModel: NSObject {
    // MARK: - Vars
    private let flickrKit: FlickrKit
    //Callback to update UI
    var loadRequest: ((_ request: URLRequest) -> ())
    var loader: ((_ status: Bool) -> ())? = nil
    var showMessage: ((_ message: String) -> ())? = nil
    var dimiss: ()->()
    // MARK: - Initializer
    init(flickrKit: FlickrKit = FlickrKit.shared()) {
        self.flickrKit = flickrKit
        self.loadRequest = { _ in }
        self.dimiss = {  }
    }
    
    // MARK: - Functions
    //loads the yahoo login
    func authenticate() {
        guard let callbackUrl = URL(string: Constants.FlickrConstants.flickrCallbackString.string) else { return }
        loader?(true)
        flickrKit.beginAuth(withCallbackURL: callbackUrl, permission: .delete) { [weak self] (url, error) in
            guard let `self` = self else { return }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.loader?(false)
                    self.showMessage?(error.localizedDescription)
                }
                print(error.localizedDescription)
            } else {
                let urlRequest = NSMutableURLRequest(url: url!, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 30) as URLRequest
                DispatchQueue.main.async {
                    self.loadRequest(urlRequest)
                }
            }
        }
    }
    //fetches user info once token is received
    func getUserInfoWith(token: URL) {
        loader?(true)
        flickrKit.completeAuth(with: token, completion: { (userName, userId, fullName, error) -> Void in
            DispatchQueue.main.async(execute: { [weak self] () -> Void in
                guard let `self` = self else { return }
                self.loader?(false)
                if let error = error {
                    self.showMessage?(error.localizedDescription)
                } else {
                    let authenticatedUser =  User(userName: userName ?? "NA", name: fullName ?? "NA", userId: userId ?? "NA", accessToken: token)
                    UserManager.shared.setUser(user: authenticatedUser)
                    self.dimiss()
                } })
        })
    }
}
