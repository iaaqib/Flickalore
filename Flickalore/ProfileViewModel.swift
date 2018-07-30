//
//  ProfileViewModel.swift
//  Flickalore
//
//  Created by Aaqib Hussain on 28/7/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import UIKit
import FlickrKit

class ProfileViewModel: NSObject {
    
    private let flickrKit: FlickrKit
    let user = UserManager.shared.getLoggedInUser()!
    private lazy var photoURLs: [URL] = []
    
    var reloadCollectionView: () -> ()
    var loader: ((_ status: Bool) -> ())? = nil
    var showMessage: ((_ message: String) -> ())? = nil
    
    var numberOfItems: Int {
        return photoURLs.count
    }
    
    
    
    init(flickrKit: FlickrKit = FlickrKit.shared()) {
        self.flickrKit = flickrKit
        self.reloadCollectionView = {}
    }
    
    func getPhotos() {
    loader?(true)
    flickrKit.call(Constants.FlickrConstants.flickrProfilePhotosSearch.string, args: ["user_id": user.userId] , maxCacheAge: FKDUMaxAge.neverCache, completion: { [weak self] (response, error) -> Void in
            guard let `self` = self else { return }
      //  DispatchQueue.main.async(execute: { () -> Void in
            if let error = error {
                DispatchQueue.main.async {
                    self.loader?(false)
                    self.showMessage?(error.localizedDescription)
                }
            } else if let response = response, let photoArray = self.flickrKit.photoArray(fromResponse: response) {
                
                photoArray.forEach({ (photoDictionary) in
                    let photoURL = self.flickrKit.photoURL(for: FKPhotoSize.small320, fromPhotoDictionary: photoDictionary)
                    
                    self.photoURLs.append(photoURL)
                })
                DispatchQueue.main.async {
                self.loader?(false)
                self.reloadCollectionView()
                }
            }
        })
        
    }
    
    func itemAtIndex(index: Int) -> URL {
        return photoURLs[index]
    }
    
    func logout() {

    flickrKit.logout()
    UserManager.shared.deleteUser()
        
    }
    
    
}
