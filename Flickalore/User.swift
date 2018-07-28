//
//  User.swift
//  Flickalore
//
//  Created by Aaqib Hussain on 28/7/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import UIKit

class User: NSObject, NSCoding {
    
    let userName: String
    let name: String
    let userId: String
    let accessToken: URL
    
    init(userName: String, name: String, userId: String, accessToken: URL) {
        self.userName = userName
        self.name = name
        self.userId = userId
        self.accessToken = accessToken
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.userName = aDecoder.decodeObject(forKey: "userName") as! String
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.userId = aDecoder.decodeObject(forKey: "userId") as! String
        self.accessToken = aDecoder.decodeObject(forKey: "accessToken") as! URL
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userName, forKey: "userName")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(userId, forKey: "userId")
        aCoder.encode(accessToken, forKey: "accessToken")
    }
    
}
