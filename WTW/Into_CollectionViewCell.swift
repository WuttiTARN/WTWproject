//
//  Into_CollectionViewCell.swift
//  WTW
//
//  Created by wuttiTARN♡ on 1/30/2560 BE.
//  Copyright © 2560 wphTarn. All rights reserved.
//

import UIKit

class Into_CollectionViewCell: UICollectionViewCell {
    
    var image_cell: UIImageView!
    
    override func awakeFromNib() {
    
        image_cell = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        self.addSubview(image_cell)
    }
    
    func setImage(image_name:String) {        
//        image_cell.image = UIImage(named: image_name)
    }
}
