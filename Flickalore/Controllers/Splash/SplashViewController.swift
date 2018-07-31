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
        //Makes Login the Root
        let loginViewController = LoginWithFlickrViewController.instantiateViewController()
        UIApplication.shared.delegate?.window??.rootViewController = loginViewController
        UIApplication.shared.delegate?.window??.makeKeyAndVisible()
        //Decides if User is Loggedin then take to Home.
        if UserManager.shared.isUserLoggedIn {
            let viewController = UITabBarController.instantiateViewController()
            loginViewController.present(viewController, animated: true)
        }
    }
    
}
