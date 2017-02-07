//
//  MainMenuModel.swift
//  WTW
//
//  Created by wuttiTARN♡ on 2/7/2560 BE.
//  Copyright © 2560 wphTarn. All rights reserved.
//

import UIKit

class MainMenuModel: NSObject {

    var id:Int!
    var name:String!
    var image:String!
    var high_score:Int!
    
    func init_data(dic:[String:Any]) {
        id = dic["id"] as! Int
        name = dic["name"] as! String
        image = dic["image"] as! String
        high_score = dic["high_score"] as! Int
    }
}
