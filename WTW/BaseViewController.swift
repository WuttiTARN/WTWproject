//
//  BaseViewController.swift
//  WTW
//
//  Created by wuttiTARN♡ on 2/7/2560 BE.
//  Copyright © 2560 wphTarn. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

//    var loading:Loading = Loading()
    
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    func setLoadingView() {
//        
//        loading = (Bundle.main.loadNibNamed("Loading", owner: nil, options: nil)?[0] as? Loading)!
//        loading.isHidden = true
//        self.view.addSubview(loading)
//    }
    
    func addShadowBtn(button:UIButton) {
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowOpacity = 2
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowRadius = 1
    }
    
    func  goToMainClass()  {
        
        let main_class = storyBoard.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
        self.navigationController?.pushViewController(main_class, animated: true)
    }
    
    func  goToPlayClass(level:Int)  {
        
        let play_class = storyBoard.instantiateViewController(withIdentifier: "PlayViewController") as! PlayViewController
        play_class.set_play_level(level: level)
        self.navigationController?.pushViewController(play_class, animated: true)
    }
    
    func goToIntroClass(){
        
        let intro_class = storyBoard.instantiateViewController(withIdentifier: "IntroController") as! IntroController
        self.navigationController?.pushViewController(intro_class, animated: true)
    }
}
