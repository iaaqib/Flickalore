//
//  AuthenticationViewController.swift
//  Flickalore
//
//  Created by Aaqib Hussain on 28/7/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import UIKit
import Toast_Swift
protocol AuthenticationDelegate: class {
    func loginSuccess()
}

class AuthenticationViewController: UIViewController {
    // MARK: - Oulet
    @IBOutlet weak var webView: UIWebView!
    // MARK: - Var
    let viewModel = AuthViewModel()
    //Informs back to login screen
    weak var delegate: AuthenticationDelegate? = nil
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelCallbacks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.authenticate()
    }
    
    // MARK: - Function
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
        
        viewModel.dimiss = { [weak self] in
            guard let `self` = self else { fatalError("self is nil") }
            self.dismiss(animated: true)
            self.delegate?.loginSuccess()
        }
    }
    // MARK: - Action
    @IBAction func dismissViewController(sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
// MARK: - WebView Delegate
extension AuthenticationViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let url = request.url
        
        //If URL scheme matches then try to do the Auth process
        if let scheme = url?.scheme, scheme == Constants.FlickrConstants.flickalore.string {
            if let token = url {
                viewModel.getUserInfoWith(token: token)
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
