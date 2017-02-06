//
//  LaunchScreenController.swift
//  WTW
//
//  Created by wuttiTARN♡ on 1/30/2560 BE.
//  Copyright © 2560 wphTarn. All rights reserved.
//

import UIKit

class LaunchScreenController: UIViewController {

    var storyBoard = UIStoryboard()
    
    @IBOutlet weak var splashscreen: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storyBoard = UIStoryboard(name: "Main", bundle: nil)
        self.perform(#selector(self.goToIntroClass),with:nil,afterDelay:2)
        
        splashscreen.image = UIImage(named:"splashscreen")

    }
    
    func goToIntroClass(){

        let intro_class = storyBoard.instantiateViewController(withIdentifier: "IntroController") as! IntroController
        self.navigationController?.pushViewController(intro_class, animated: true)
    }
}
