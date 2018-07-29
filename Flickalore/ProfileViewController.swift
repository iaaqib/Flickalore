//
//  ProfileViewController.swift
//  Flickalore
//
//  Created by Aaqib Hussain on 28/7/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    let viewModel = ProfileViewModel()
    
    var widthForItem: CGFloat = Constants.screenBounds.width / 3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(ImageCollectionViewCell.self)
        setupViewModelCallbacks()
        setupViews()
        viewModel.getPhotos()
    }

    private func setupViews() {
        fullNameLabel.text = "Welcome \(viewModel.user.name)"
        userNameLabel.text = viewModel.user.userName
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
        
        viewModel.reloadCollectionView = { [weak self] in
         guard let `self` = self else { fatalError("self is nil") }
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func logOutAction(_ sender: UIBarButtonItem) {
        viewModel.logout()
        tabBarController?.dismiss(animated: true, completion: nil)
    }

}
extension ProfileViewController: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.className, for: indexPath) as! ImageCollectionViewCell
        let url = viewModel.itemAtIndex(index: indexPath.row)
        cell.item(url: url)
        return cell
    }
}
extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        let selectedImage = cell.imageView.image
        let zoomViewController = PinchZoomViewController.instantiateViewController()
        zoomViewController.image = selectedImage
        navigationController?.pushViewController(zoomViewController, animated: true)
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        let portraitSize = Constants.screenBounds.size
        
        if size == portraitSize {
           self.widthForItem = size.width / 3
        } else {
           self.widthForItem = size.width / 3
        }
            print(self.widthForItem)
            self.collectionView.reloadData()
        
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: widthForItem , height: widthForItem )
    }
}

