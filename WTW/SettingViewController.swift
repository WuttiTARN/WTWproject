//
//  SettingViewController.swift
//  WTW
//
//  Created by wuttiTARN♡ on 2/2/2560 BE.
//  Copyright © 2560 wphTarn. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackPressed(_ sender: Any) {
        // code go to previous scene
        self.dismiss(animated: true, completion: nil)
//        _ = navigationController?.popViewController(animated: true)
    }
}
