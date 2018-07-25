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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0


    }
    
}
extension PinchZoomViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
