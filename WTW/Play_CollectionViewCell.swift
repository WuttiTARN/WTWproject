//
//  Play_CollectionViewCell.swift
//  WTW
//
//  Created by wuttiTARN♡ on 1/30/2560 BE.
//  Copyright © 2560 wphTarn. All rights reserved.
//

import UIKit
import Kingfisher

class Play_CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image_cell: UIImageView!
    
    func setImageCell(image_array:NSMutableDictionary){
        self.image_cell.kf.setImage(with: URL(string: "\((image_array["image"])!)"));
    }
}
