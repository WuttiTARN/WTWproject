//
//  MainMenuModel.swift
//  WTW
//
//  Created by wuttiTARN♡ on 2/7/2560 BE.
//  Copyright © 2560 wphTarn. All rights reserved.
//

import UIKit
import Foundation
import Firebase

protocol IMainMenu {
    
    func init_data(dic:[String:Any])
    func getUserCount() -> Int
    func getUserData()
    func registerUnknownUser(new_user:[String:Any])
    func loginFacebookToFirebase(credential:FIRAuthCredential,data:[String:AnyObject])
    func setUserData(dic:NSMutableDictionary)
}

