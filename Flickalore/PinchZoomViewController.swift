//
//  PinchZoomViewController.swift
//  Flickalore
//
//  Created by Aaqib Hussain on 25/7/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import UIKit

class PinchZoomViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        
        self.imageView.image = image
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        print(parent)
        if parent == nil {
//    navigationController?.navigationBar.setBackgroundImage(UINavigationBar().backgroundImage(for: .default), for: .default)
//        navigationController?.navigationBar.shadowImage = UINavigationBar().shadowImage
//        navigationController?.setNavigationBarHidden(true, animated: true)
            self.navigationController?.hideTransparentNavigationBar()
           
        } else {
             self.navigationController?.presentTransparentNavigationBar()
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
}
extension PinchZoomViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}

