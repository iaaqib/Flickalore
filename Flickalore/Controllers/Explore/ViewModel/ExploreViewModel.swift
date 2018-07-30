//
//  ExploreViewModel.swift
//  Flickalore
//
//  Created by Aaqib Hussain on 30/7/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import UIKit
import FlickrKit
import Reachability

class ExploreViewModel: NSObject {
    // MARK: - Vars
    private let flickrKit: FlickrKit
    private lazy var photoURLs: [URL] = []
    private var pageNumber: String = "1"
    private let reachability = Reachability()!
    //Callbacks to update UI
    var reloadCollectionView: () -> ()
    var loader: ((_ status: Bool) -> ())? = nil
    var showMessage: ((_ message: String) -> ())? = nil
    //Collection Datasource no. of items
    var numberOfItems: Int {
        return photoURLs.count
    }
    // MARK: - Initializer
    init(flickrKit: FlickrKit = FlickrKit.shared()) {
        self.flickrKit = flickrKit
        self.reloadCollectionView = {}
    }
    // MARK: - Functions
    //Fetches explore section of Flickr
    func loadExplore() {
        reachability.whenReachable = { [weak self] reachability in
            guard let `self` = self else { return }
            if reachability.connection == .wifi || reachability.connection == .cellular {
                self.getExplore()
            } else {
                self.showMessage?(Constants.internetConnectivityMessage)
            }
        }
        reachability.whenUnreachable = { [weak self] _ in
            guard let `self` = self else { return }
            self.showMessage?(Constants.internetConnectivityMessage)
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    private func getExplore(page: String = "1") {
        loader?(true)
        let flickrInteresting = FKFlickrInterestingnessGetList()
        flickrInteresting.per_page = "20"
        flickrInteresting.page = page
        flickrKit.call(flickrInteresting) { [weak self] (response, error) -> Void in
            guard let `self` = self else { return }
            if let error = error  {
                DispatchQueue.main.async {
                    self.loader?(false)
                    self.showMessage?(error.localizedDescription)
                }
                
            } else if let response = response, let photoArray = self.flickrKit.photoArray(fromResponse: response) {
                
                photoArray.forEach({ photoDictionary in
                    let photoURL = self.flickrKit.photoURL(for: FKPhotoSize.small320 , fromPhotoDictionary: photoDictionary)
                    self.photoURLs.append(photoURL)
                })
                DispatchQueue.main.async {
                    self.loader?(false)
                    self.reloadCollectionView()
                }
            }
        }
    }
    //Returns an item at a given index
    func itemAtIndex(index: Int) -> URL {
        return photoURLs[index]
    }
    //Loads more photos from Explore
    func loadMore(index: Int) {
        if index == photoURLs.count - 1 {
            pageNumber = (pageNumber.toInt + 1).toString
            getExplore(page: pageNumber)
        
        }
    }
    // MARK: - De-initialzier
    deinit {
        reachability.stopNotifier()
    }
}
