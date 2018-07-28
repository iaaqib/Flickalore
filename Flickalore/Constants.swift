//
//  Constants.swift
//  Flickalore
//
//  Created by Aaqib Hussain on 28/7/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import UIKit

class Constants: NSObject {

    static let screenBounds = UIScreen.main.bounds
    
    enum APIKeys: String {
        case apiKey = "5439af32e3b717c28e0434f84c57cf5a"
        case secret = "52e6668d9ca84bb5"
        
        var value: String {
         return self.rawValue
        }
    }
    
    enum FlickrConstants: String {
        case flickalore = "flickalore"
        case flickrHome = "https://www.flickr.com/"
        case flickrCallbackString = "flickalore://auth"
        case flickrProfilePhotosSearch = "flickr.photos.search"
       
        var string: String {
            return self.rawValue
        }
    }
    
    
    
    
}
