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
    
    @IBAction func saveImage(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)

    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            self.view.makeToast(error.localizedDescription, duration: 1, position: .center)
        } else {
            self.view.makeToast(Constants.Messages.photoSaved.string, duration: 1, position: .center)
        }
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

