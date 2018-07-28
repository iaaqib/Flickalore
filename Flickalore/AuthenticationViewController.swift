//
//  AuthenticationViewController.swift
//  Flickalore
//
//  Created by Aaqib Hussain on 28/7/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import UIKit
import Toast_Swift

class AuthenticationViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    let viewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupViewModelCallbacks()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.authenticate()
    }
    
    private func setupViewModelCallbacks() {
        viewModel.loader = { [weak self] state in
            guard let `self` = self else { fatalError("self is nil") }
            
            if state {
            self.view.makeToastActivity(.center)
            } else {
            self.view.hideToastActivity()
            }
           
        }
      
        viewModel.showMessage = { [weak self] message in
            guard let `self` = self else { fatalError("self is nil") }
            self.view.makeToast(message, duration: 0.4, position: .center)
        }
        
        viewModel.loadRequest = { [weak self] request in
           guard let `self` = self else { fatalError("self is nil") }
            self.webView.loadRequest(request)
        }
    }
    
    @IBAction func dismissViewController(sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
extension AuthenticationViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let url = request.url
        
        //If URL scheme matches then try to do the Auth process
        if let scheme = url?.scheme, scheme == Constants.FlickrConstants.flickalore.string {
            if let token = url {
                
            viewModel.checkAuthentication(token: token)
            self.dismiss(animated: true)
            }
        } else if url?.absoluteString == Constants.FlickrConstants.flickrHome.string {
            self.dismiss(animated: true)
          
        }
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.view.hideToastActivity()
    }
    
}
