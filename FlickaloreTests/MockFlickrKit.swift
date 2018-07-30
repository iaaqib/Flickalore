//
//  MockFlickrKit.swift
//  FlickaloreTests
//
//  Created by Aaqib Hussain on 31/7/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import FlickrKit

class MockFlickrKit: FlickrKit {
    
    override func call(_ apiMethod: String, args requestArgs: [AnyHashable : Any]?, maxCacheAge maxAge: FKDUMaxAge, completion: FKAPIRequestCompletion? = nil) -> FKFlickrNetworkOperation {
        let profileData = loadJson(name: "ProfileData")
        completion!(profileData, nil)
        return FKFlickrNetworkOperation(apiMethod: apiMethod, arguments: requestArgs, maxAgeMinutes: maxAge, diskCache: FKDUDiskCache?.none, completion: completion)
    }
    
    override func call(_ method: FKFlickrAPIMethod, completion: FKAPIRequestCompletion? = nil) -> FKFlickrNetworkOperation {
        let exploreData = loadJson(name: "ExploreData")
        completion?(exploreData, nil)
        return FKFlickrNetworkOperation(apiMethod: method, maxAgeMinutes: .neverCache, diskCache: FKDUDiskCache?.none, completion: completion)
    }
    
    func loadJson(name: String) -> [String : Any]? {
        if let path = Bundle.main.path(forResource: name, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .dataReadingMapped)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String : Any]
                return jsonResult
            } catch {
                // handle error
                print(error.localizedDescription)
                return nil
            }
        }
        return nil
    }
    
}
