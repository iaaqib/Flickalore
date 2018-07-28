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
    
    private let flickrKit: FlickrKit
    
    init(flickrKit: FlickrKit = FlickrKit.shared()) {
        self.flickrKit = flickrKit
        self.loadRequest = { _ in }
        self.dimiss = {  }
    }
    
    var loadRequest: ((_ request: URLRequest) -> ())
    var loader: ((_ status: Bool) -> ())? = nil
    var showMessage: ((_ message: String) -> ())? = nil
    var dimiss: ()->()
    
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
