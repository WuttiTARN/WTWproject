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
        
        self.perform(#selector(self.goToIntroClass),with:nil,afterDelay:2)
        //ถ้าไม่เนี้ยบพอ ให้เปิดตรงนี้ไว้เช็ค
        //        UserDefaults.standard.removeObject(forKey: "FIRSTTIME_LAUNCHING")
        
        // check ว่า มีค่าหรือไม่ ถ้ามีค่า แสดงว่าเคยเข้า app มาแล้ว ดังนั้นจะไม่มีการแสดงหน้า introduction
//        let result = UserDefaults.standard.value(forKey: "FIRSTTIME_LAUNCHING")
//        
//        if checkFirstTimeAccess(result: result as! String) == true {
//            UserDefaults.standard.set("false",forKey:"FIRSTTIME_LAUNCHING")
//            self.perform(#selector(self.goToIntroClass),with:nil,afterDelay:2)
//        }else{
//            self.perform(#selector(self.goToMainClass),with:nil,afterDelay:2)
//        }
        }
    
    func checkFirstTimeAccess(result:String) -> Bool{
        
        if(result.characters.count == 0){
            return true
        }
        return false
    }
}
