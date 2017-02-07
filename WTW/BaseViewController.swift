//
//  BaseViewController.swift
//  WTW
//
//  Created by wuttiTARN♡ on 2/7/2560 BE.
//  Copyright © 2560 wphTarn. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func  goToMainClass()  {
        
        UserDefaults.standard.set("NO",forKey:"FIRSTTIME_LAUNCHING")
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let main_class = storyBoard.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
        self.navigationController?.pushViewController(main_class, animated: true)
    }
}
