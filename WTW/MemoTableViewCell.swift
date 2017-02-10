//
//  MemoTableViewCell.swift
//  WTW
//
//  Created by wuttiTARN♡ on 2/10/2560 BE.
//  Copyright © 2560 wphTarn. All rights reserved.
//

import UIKit

class MemoTableViewCell: UITableViewCell {

    @IBOutlet weak var memo_cell: UIView!
    
    @IBOutlet weak var memo_image: UIImageView!
    
    @IBOutlet weak var memo_name: UILabel!
    
    @IBOutlet weak var memo_des: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
            
            //ทำกรอบcellให้โค้งมน
            memo_cell.layer.cornerRadius = 26
        
        let base_class:BaseViewController = BaseViewController()
            base_class.addShadowView(view: memo_cell)
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
