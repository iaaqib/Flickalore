//
//  ProfileViewModel.swift
//  Flickalore
//
//  Created by Aaqib Hussain on 28/7/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import UIKit
import FlickrKit
import Reachability

class ProfileViewModel: NSObject {
    //MARK: - Vars
    private let flickrKit: FlickrKit
    private let reachability = Reachability()!
    private lazy var photoURLs: [URL] = []
    let user = UserManager.shared.getLoggedInUser()!
    //Callbacks to update UI
    var reloadCollectionView: () -> ()
    var loader: ((_ status: Bool) -> ())? = nil
    var showMessage: ((_ message: String) -> ())? = nil
    //CollectionView data source no. of items
    var numberOfItems: Int {
        return photoURLs.count
    }
    
    //MARK: - Initializer
    init(flickrKit: FlickrKit = FlickrKit.shared()) {
        self.flickrKit = flickrKit
        self.reloadCollectionView = {}
    }
    //MARK: - Functions
    func loadPhotos() {
        reachability.whenReachable = { [weak self] reachability in
            guard let `self` = self else { return }
            if reachability.connection == .wifi || reachability.connection == .cellular {
                self.checkAuthorization()
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
    //Checks user authenticity
    private func checkAuthorization() {
        loader?(true)
        flickrKit.checkAuthorization { [weak self] (userName, userId, fullName, error) -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
                guard let `self` = self else { return }
                if let error = error {
                    self.loader?(false)
                    self.showMessage?(error.localizedDescription)
                } else {
                    let authenticatedUser =  User(userName: userName ?? "NA", name: fullName ?? "NA", userId: userId ?? "NA", accessToken: self.user.accessToken)
                    UserManager.shared.setUser(user: authenticatedUser)
                    self.getPhotos()
                }
            })
        }
    }
    //Gets all the photos
    func getPhotos() {
        loader?(true)
        flickrKit.call(Constants.FlickrConstants.flickrProfilePhotosSearch.string, args: ["user_id": user.userId] , maxCacheAge: FKDUMaxAge.neverCache, completion: { [weak self] (response, error) -> Void in
            guard let `self` = self else { return }
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
    //returns item at given index
    func itemAtIndex(index: Int) -> URL {
        return photoURLs[index]
    }
    //Logout from Flickr
    func logout() {
        flickrKit.logout()
        UserManager.shared.deleteUser()
    }
    //MARK: - De-initializer
    deinit {
        reachability.stopNotifier()
    }
    
}
