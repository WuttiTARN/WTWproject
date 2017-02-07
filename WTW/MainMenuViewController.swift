//
//  MainMenuViewController.swift
//  WTW
//
//  Created by wuttiTARN♡ on 1/30/2560 BE.
//  Copyright © 2560 wphTarn. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FBSDKLoginKit

class MainMenuViewController: UIViewController {
    
    var main_menu_model:MainMenuModel = MainMenuModel()
    
    var dic_db:NSMutableDictionary = NSMutableDictionary()
    var ref = FIRDatabase.database().reference()
    
    @IBOutlet weak var bg_main: UIImageView!
    @IBAction func btn_easy(_ sender: UIButton) {}
    @IBAction func btn_medium(_ sender: UIButton) {}
    @IBAction func btn_hard(_ sender: UIButton) {}
    @IBOutlet weak var view_rank: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        set_ui()
        getUserData()
        bg_main.image = UIImage(named:"main")
    }
    
    @IBAction func btnPlayPressed(_ sender: Any) {
        //if 1,2 ทำอะไร เอล 3 ทำอะไร เข้าฟังก์ชันอะไรก็ว่าไป
        print("= ",(sender as AnyObject).tag)
        
        let result = UserDefaults.standard.value(forKey: "USER_INFO")
        print(result!)
        
        if (result == nil){
            
            print("user not login")
            
            let new_user:[String:Any] = [
                "id":dic_db.count+1,
                "name":String(format:"Unknown%d",dic_db.count+1),
                "image":" " ,
                "high_score":0] as [String:Any]

            registerUser(new_user: new_user)
            
        }else {
            print("already login")
        }
    }
    
    func getUserData(){
        
        // retreivce data from firebase
        ref.observe(.value) { (snap: FIRDataSnapshot) in
            self.dic_db = (snap.value as! NSMutableDictionary).mutableCopy() as! NSMutableDictionary
        }
    }
    
    func setUserData(dic:NSMutableDictionary) {
        
        let users_dic:NSMutableDictionary = dic_db["Users"] as! NSMutableDictionary
        
        var i: Int = 0
        var userAlreadyExist:Bool = false
        var user_dic:NSMutableDictionary!
        var username_login,username_db:String!
        
        // find user count number
        for _ in users_dic{
            
            let key = String(format:"user:%d",i+1)
            user_dic = users_dic[key] as! NSMutableDictionary
            
            username_login = String(format:"%@",dic["name"] as! String)
            username_db = String(format:"%@",user_dic["name"] as! String)
            
            // check user's facebook name with username in DB
            if (username_login != username_db){
                userAlreadyExist = false
            }else{
                userAlreadyExist = true
                break
            }
            i += 1
        }
        
        let new_user_info:[String:Any]!
        
        if (userAlreadyExist == false){

            new_user_info = [
                "id":user_dic.count+1,
                "name":username_login as String,
                "image":dic["image"] as! String,
                "high_score":0] as [String:Any]
            
            registerUser(new_user: new_user_info)
        
        }else{
            
            new_user_info = [
                "id":user_dic.count,
                "name":username_login as String,
                "image":dic["image"] as! String,
                "high_score":dic["high_score"] as! Int] as [String:Any]
        }
        
        main_menu_model.init_data(dic: new_user_info)
        test()
        
        UserDefaults.standard.set(dic,forKey:"USER_INFO")
        self.ref.removeAllObservers()
    }
    
    // register new user
    func registerUser(new_user:[String:Any]) {
        
        let new_key = String(format: "user:%d",dic_db.count+1)
        let itemRef = self.ref.child("Users").child(new_key)
        itemRef.setValue(new_user)
    }
    
    func test(){
        
        print("test ",main_menu_model.name)
    }
}

extension MainMenuViewController:FBSDKLoginButtonDelegate{
    /**
     Sent to the delegate when the button was used to logout.
     - Parameter loginButton: The button that was clicked.
     */
    public func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        UserDefaults.standard.removeObject(forKey: "USER_INFO")
        
    }
    
    func set_ui (){
        
        let loginButton = FBSDKLoginButton()
        loginButton.frame = CGRect(x: 0, y: 0, width: 67, height: 54)
        loginButton.delegate = self
        self.view_rank.addSubview(loginButton)
        
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result:FBSDKLoginManagerLoginResult!, error: Error!) {
        
        let graphRequest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"])
        
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil){
                
                print("Error: \(error)")
                
            }else{
                
                let data:[String:AnyObject] = result as! [String : AnyObject]
                
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                    // ...
                    if error != nil {
                        print("Error: \(error)")
                        return
                    }
                    
                    let facebookProfileUrl = "http://graph.facebook.com/\(data["id"]!)/picture?width=\(600)&height=\(800)"
                    
                    let dic: NSMutableDictionary? = ["id" :data["id"] as! String,
                                                     "name" : data["name"] as! String,
                                                     "image" : facebookProfileUrl,
                                                     "high_score" : 0
                    ]
                    
                    self.setUserData(dic: dic!)
                    
                    //ใส่โค้ดเปลี่ยนหน้า ไปหน้า rank
                }
            }
        })
    }
}


