//
//  MainMenuView.swift
//  WTW
//
//  Created by wuttiTARN♡ on 1/30/2560 BE.
//  Copyright © 2560 wphTarn. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FBSDKLoginKit

class MainMenuViewController: BaseViewController {
    
    /// UI
    @IBOutlet weak var bg_main: UIImageView!
    @IBAction func btn_easy(_ sender: UIButton) {}
    @IBAction func btn_medium(_ sender: UIButton) {}
    @IBAction func btn_hard(_ sender: UIButton) {}
    ///
    
    var main_menu_controller:MainMenuModel = MainMenuModel()
    
    /*
     อันดับการทำงานของ method
     1. viewWillAppear จะเข้า method นี้ ก่อนที่ view นี้จะทำการแสดง ต่อ user
     2. viewDidLoad พอ view นี้ถูกแสดงแล้ว ถึงจะทำการเข้า method นี้
     
     */
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.main_menu_controller.getUserData()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //กันตาย เผื่อส่งข้อมูลอยู่ แล้ว user กด มี true ต้องมี false
        self.view.isUserInteractionEnabled = false
        
        //ส่งสัญญาณข้ามหน้า เราทำงานเสร็จแล้วนะ --> ส่งเข้า method ที่ตั้งไว้
        NotificationCenter.default.addObserver(self, selector: #selector(self.setDataToModel(_:)), name: NSNotification.Name(rawValue: "SET_DATA"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setDataToModel(_ notification: NSNotification) {
        self.view.isUserInteractionEnabled = true
    }
    
    @IBAction func btnPlayPressed(_ sender: Any) {
        
        let play_level:Int = (sender as AnyObject).tag
        print("play level that user choosed = ",play_level)
        
        let get_user_info = UserDefaults.standard.value(forKey: "USER_INFO")
        
        if (get_user_info == nil){
            
            print("user's not login")
            
            let new_user:[String:Any] = [
                "id":main_menu_controller.getUserCount()+1,
                "name":String(format:"Unknown%d",main_menu_controller.getUserCount()+1),
                "image":" " ,
                "high_score":0] as [String:Any]
            
            main_menu_controller.registerUnknownUser(new_user: new_user)
            
        }else {
            
            let user_dic:NSMutableDictionary = get_user_info as! NSMutableDictionary
            main_menu_controller.setUserData(dic: user_dic)
            print("user's already login")
        }
        
        goToPlayClass(level:play_level)
    }
    
    @IBAction func btnRankPressed(_ sender: Any) {
        
        let get_user_info = UserDefaults.standard.value(forKey: "USER_INFO")
        
        if (get_user_info == nil){
            
            //TODO: Condition Log in with Facebook, rank
            let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
            
            fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
                
                if (error == nil){
                    
                    let graphRequest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"])
                    
                    graphRequest.start(completionHandler: { (connection, result, error) -> Void in
                        
                        if ((error) != nil){
                            
                            print("Error: \(error)")
                            
                        }else{
                            
                            let data:[String:AnyObject] = result as! [String : AnyObject]
                            let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                            
                            self.main_menu_controller.loginFacebookToFirebase(credential: credential, data: data)
                            
                            //ใส่โค้ดเปลี่ยนหน้า ไปหน้า rank
                        }
                    })
                }
            }
        } else {
            goToRank()
        }
    }
}


