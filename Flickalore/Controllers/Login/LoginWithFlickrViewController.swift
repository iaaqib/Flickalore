//
//  ViewController.swift
//  Flickalore
//
//  Created by Aaqib Hussain on 25/7/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import UIKit

class LoginWithFlickrViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //MARK: - Action
    //Authentication Screen
    @IBAction func sendToLogin(_ sender: UIButton) {
        let authenticationViewController = AuthenticationViewController.instantiateViewController()
        authenticationViewController.delegate = self
        present(authenticationViewController, animated: true)
    }
}
//MARK: - Authentication Delegate
extension LoginWithFlickrViewController: AuthenticationDelegate {
    func loginSuccess() {
        let tabBarController = UITabBarController.instantiateViewController()
        present(tabBarController, animated: true)
    }
}

