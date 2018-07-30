//
//  ExploreViewController.swift
//  Flickalore
//
//  Created by Aaqib Hussain on 29/7/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var widthForItem: CGFloat = Constants.screenBounds.width / 3
    
    let viewModel = ExploreViewModel()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ImageCollectionViewCell.self)
        setupViewModelCallbacks()
        viewModel.getExplore()
        
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
        
        viewModel.reloadCollectionView = { [weak self] in
            guard let `self` = self else { fatalError("self is nil") }
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        widthForItem = size.width / 3
        collectionView.reloadData()
    }
    
}
extension ExploreViewController: UICollectionViewDataSource {
    
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
extension ExploreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        let selectedImage = cell.imageView.image
        let zoomViewController = PinchZoomViewController.instantiateViewController()
        zoomViewController.image = selectedImage
        navigationController?.pushViewController(zoomViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.loadMore(index: indexPath.row)
    }
    
}

extension ExploreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: widthForItem , height: widthForItem )
    }
}


