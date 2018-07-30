//
//  SplashViewController.swift
//  Flickalore
//
//  Created by Aaqib Hussain on 30/7/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perform(#selector(loadController), with: nil, afterDelay: 0.6)
    }
    
    @objc func loadController() {
        //Decides which screen to take user to on basis of isUserLoggedIn
        let viewController = UserManager.shared.isUserLoggedIn ? UITabBarController.instantiateViewController() : LoginWithFlickrViewController.instantiateViewController()
        self.present(viewController, animated: true)
    }
    
}
