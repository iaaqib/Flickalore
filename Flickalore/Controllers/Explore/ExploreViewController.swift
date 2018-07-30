//
//  ExploreViewController.swift
//  Flickalore
//
//  Created by Aaqib Hussain on 29/7/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {
    // MARK: - Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Vars
    var widthForItem: CGFloat = Constants.screenBounds.width / 3
    let viewModel = ExploreViewModel()
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupViewModelCallbacks()
        viewModel.loadExplore()
    }
    // MARK: - Functions
    private func setupViews() {
        collectionView.register(ImageCollectionViewCell.self)
    }
    private func setupViewModelCallbacks() {
        //Shows or hides loader
        viewModel.loader = { [weak self] state in
            guard let `self` = self else { fatalError("self is nil") }
            
            if state {
                self.view.makeToastActivity(.center)
            } else {
                self.view.hideToastActivity()
            }
        }
        //Shows any error message
        viewModel.showMessage = { [weak self] message in
            guard let `self` = self else { fatalError("self is nil") }
            self.view.makeToast(message, duration: 1, position: .center)
        }
        //Reloads collectionview
        viewModel.reloadCollectionView = { [weak self] in
            guard let `self` = self else { fatalError("self is nil") }
            self.collectionView.reloadData()
        }
    }
    // MARK: - Orientation Changed
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        widthForItem = size.width / 3
        collectionView.reloadData()
    }
    
}
// MARK: - CollectionView Datasource
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
// MARK: - CollectionView Delegate
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
// MARK: - CollectionView FlowLayout
extension ExploreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: widthForItem, height: widthForItem)
    }
}


