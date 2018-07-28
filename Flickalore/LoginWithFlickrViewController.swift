//
//  ViewController.swift
//  Flickalore
//
//  Created by Aaqib Hussain on 25/7/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import UIKit

class LoginWithFlickrViewController: UIViewController {

    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewModelCallback()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        viewModel.isUserLoggedIn()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
//        viewModel.isUserLoggedIn { [weak self] in
//            let tabBarController = UITabBarController.instantiateViewController()
//            self?.present(tabBarController, animated: true)
//        }
       
    }
    
    func setupViewModelCallback() {
        viewModel.isLoggedIn = { [weak self] in
            let tabBarController = UITabBarController.instantiateViewController()
            self?.present(tabBarController, animated: true)
        }
    }

    

}

