//
//  TutorialViewController.swift
//  WTW
//
//  Created by wuttiTARN♡ on 2/2/2560 BE.
//  Copyright © 2560 wphTarn. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    @IBOutlet weak var show_tutorial: UIScrollView!

    var size = CGSize(width: 375, height: 1390)
    
    override func viewDidLoad() {
        super.viewDidLoad()

       show_tutorial.contentSize = size
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_leave(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
//        _ = navigationController?.popViewController(animated: true)
    }
}
