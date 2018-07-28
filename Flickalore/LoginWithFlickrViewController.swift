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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        if UserManager.shared.isUserLoggedIn {
            let tabBarController = UITabBarController.instantiateViewController()
            present(tabBarController, animated: true)
        }
    }

    

}

