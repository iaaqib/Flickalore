//
//  Extensions.swift
//  Flickalore
//
//  Created by Aaqib Hussain on 28/7/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import UIKit

extension NSObject {
    
    static var className: String {
        return String(describing: self)
    }
}

extension UIStoryboard {
    
    enum Storyboard: String {
        case main
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    class func storyboard(storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }
}

extension Initializable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    static var storyboardName: UIStoryboard.Storyboard {
        return UIStoryboard.Storyboard.main
    }
    static func instantiateViewController() -> Self {
        let storyboard = UIStoryboard.storyboard(storyboard: storyboardName)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
        
    }
}

extension UIViewController: Initializable {}

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.className, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.className)
    }
    
}

extension UINavigationController {
    
    public func hideTransparentNavigationBar() {
    //navigationBar.setBackgroundImage(UINavigationBar().backgroundImage(for: .default), for: .default)
    //navigationBar.shadowImage = UINavigationBar().shadowImage
    setNavigationBarHidden(false, animated: true)
    }

    public func presentTransparentNavigationBar() {
    //    navigationBar.setBackgroundImage(UIImage(), for: .default)
    //    navigationBar.shadowImage = UIImage()
        setNavigationBarHidden(true, animated: true)
    }
}

