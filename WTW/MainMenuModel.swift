//
//  MainMenuController.swift
//  WTW
//
//  Created by pimpaporn chaichompoo on 2/8/17.
//  Copyright © 2017 wphTarn. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MainMenuModel: IMainMenu {
    
    var id:Int!
    var name:String!
    var image:String!
    var high_score:Int!
    var users_count:Int!
    
    var dic_db:NSMutableDictionary = NSMutableDictionary()
    var ref = FIRDatabase.database().reference()
    
    func init_data(dic:[String:Any]) {
        
        id = dic["id"] as! Int
        name = dic["name"] as! String
        image = dic["image"] as! String
        high_score = dic["high_score"] as! Int
    }
    
    func getUserCount() -> Int {
        return users_count
    }

    // retreivce data from firebase
    func getUserData(){
        
        ref.observe(.value) { (snap: FIRDataSnapshot) in
            
            var user_data:NSMutableDictionary = NSMutableDictionary()
            user_data = (snap.value as! NSMutableDictionary).mutableCopy() as! NSMutableDictionary

            self.users_count = (user_data["Users"] as! NSMutableDictionary).count
            self.dic_db = user_data["Users"] as! NSMutableDictionary
        
            print("get user ",self.dic_db)
            
            NotificationCenter.default.post(name:NSNotification.Name(rawValue: "SET_DATA"), object: nil)
        }
    }
    
    // register new user
    func registerUnknownUser(new_user:[String:Any]) {
        
        let new_key = String(format: "user:%d",users_count+1)
        let itemRef = self.ref.child("Users").child(new_key)
        itemRef.setValue(new_user)
    }
    
    func loginFacebookToFirebase(credential:FIRAuthCredential,data:[String:AnyObject]){
        
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in

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
        }
    }
    
    func setUserData(dic:NSMutableDictionary) {
        
        let users_dic:NSMutableDictionary = dic_db
        
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
            
            registerUnknownUser(new_user: new_user_info)
            
        }else{
            
            new_user_info = [
                "id":user_dic.count,
                "name":username_login as String,
                "image":dic["image"] as! String,
                "high_score":dic["high_score"] as! Int] as [String:Any]
        }
        
        init_data(dic: new_user_info)
        
        UserDefaults.standard.set(dic,forKey:"USER_INFO")
//        self.ref.removeAllObservers()
    }
}
