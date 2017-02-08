//
//  LaunchScreenController.swift
//  WTW
//
//  Created by wuttiTARN♡ on 1/30/2560 BE.
//  Copyright © 2560 wphTarn. All rights reserved.
//

import UIKit

class LaunchScreenController: BaseViewController {
        
    @IBOutlet weak var splashscreen: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        //ถ้าไม่เนี้ยบพอ ให้เปิดตรงนี้ไว้เช็ค
//        UserDefaults.standard.removeObject(forKey: "FIRSTTIME_LAUNCHING")

        //getค่าจากkey user default ว่ามีไหม ใส่ตัวแปร result
        let result = UserDefaults.standard.value(forKey: "FIRSTTIME_LAUNCHING")
        
        if(result == nil){
            self.perform(#selector(self.goToIntroClass),with:nil,afterDelay:2)
        }else {
            self.perform(#selector(self.goToMainClass),with:nil,afterDelay:2)
        }
    }
}
