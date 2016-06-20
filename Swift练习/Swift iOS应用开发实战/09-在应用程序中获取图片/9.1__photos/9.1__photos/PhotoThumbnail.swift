//
//  PhotoThumbnail.swift
//  9.1__photos
//
//  Created by M-coppco on 16/6/21.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import UIKit

class PhotoThumbnail: UICollectionViewCell {
    
    @IBOutlet weak var imageV: UIImageView!

    func setThumbnailImage(image: UIImage) {
        self.imageV.image = image
    }
}
