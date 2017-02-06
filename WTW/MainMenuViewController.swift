//
//  MainMenuViewController.swift
//  WTW
//
//  Created by wuttiTARN♡ on 1/30/2560 BE.
//  Copyright © 2560 wphTarn. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var bg_main: UIImageView!
    
    @IBAction func btn_easy(_ sender: UIButton) {}
    
    @IBAction func btn_medium(_ sender: UIButton) {}
    
    @IBAction func btn_hard(_ sender: UIButton) {}
    
    @IBAction func btn_rank(_ sender: UIButton) {
        
        //btn_rank.image("btnrank", for: [])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        bg_main.image = UIImage(named:"main")
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
