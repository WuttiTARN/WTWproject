//
//  MainMenuViewController.swift
//  WTW
//
//  Created by wuttiTARN♡ on 1/30/2560 BE.
//  Copyright © 2560 wphTarn. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var bg_main: UIImageView!
    
    @IBAction func btn_easy(_ sender: UIButton) {}
    
    @IBAction func btn_medium(_ sender: UIButton) {}
    
    @IBAction func btn_hard(_ sender: UIButton) {}
    
    @IBOutlet weak var view_rank: UIView!
    
    @IBAction func btn_rank(_ sender: UIButton) {
        
        //btn_rank.image("btnrank", for: [])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        set_ui()
        bg_main.image = UIImage(named:"main")
        
    }
    @IBAction func btnPlayPressed(_ sender: Any) {
        //if 1,2 ทำอะไร เอล 3 ทำอะไร เข้าฟังก์ชันอะไรก็ว่าไป
        print("= ",(sender as AnyObject).tag)
        
        let result = UserDefaults.standard.value(forKey: "USER_INFO")
        print(result)
        
        if (result == nil){
            print("user not login")
        }else {
            print("already login")
        }
        
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
                                                     "user_picture" : facebookProfileUrl
                    ]
                    
                    print("dic ",dic)
                    
                    
                    UserDefaults.standard.set(dic,forKey:"USER_INFO")
                    //ใส่โค้ดเปลี่ยนหน้า ไปหน้า rank
                }
            }
        })
    }
}


