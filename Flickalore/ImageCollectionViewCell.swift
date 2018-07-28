//
//  ImageCollectionViewCell.swift
//  Flickalore
//
//  Created by Aaqib Hussain on 28/7/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func item(url: URL) {
        imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "gallery"))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
