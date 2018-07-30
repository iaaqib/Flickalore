//
//  PinchZoomViewController.swift
//  Flickalore
//
//  Created by Aaqib Hussain on 25/7/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import UIKit

class PinchZoomViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    // MARK: - Var
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    // MARK: - Function
    private func setupViews() {
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        imageView.image = image
    }
    // MARK: - Action
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        if parent == nil {
            self.navigationController?.hideTransparentNavigationBar()
        } else {
             self.navigationController?.presentTransparentNavigationBar()
        }
    }
    
}
// MARK: - ScrollView Delegate
extension PinchZoomViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}

