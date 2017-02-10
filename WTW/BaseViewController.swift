//
//  BaseViewController.swift
//  WTW
//
//  Created by wuttiTARN♡ on 2/7/2560 BE.
//  Copyright © 2560 wphTarn. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    //var loading:Loading = Loading()
    
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
    
    func randomArray(old_array:NSMutableArray) -> NSMutableArray{
        
        let count:NSInteger = old_array.count - 1
        
        if (count > 1){
            
            var i:Int = 0
            
            for _ in 0...count{
                
                old_array.exchangeObject(at: i, withObjectAt: Int(arc4random_uniform(UInt32((__int32_t)(i + 1)))))
                i = i+1
            }
        }
        
        let new_array = NSMutableArray.init(array: old_array)
        return new_array
    }
    
    func addShadowBtn(button:UIButton) {
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowRadius = 3
    }
    
    func addShadowView(view:UIView) {
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 3
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
    
    func goToSetting(){
        
        let setting_class = storyBoard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        self.navigationController?.pushViewController(setting_class, animated: true)
    }
    
    func goToRank(){
        
        let rank_class = storyBoard.instantiateViewController(withIdentifier: "RankViewController") as! RankViewController
        self.navigationController?.pushViewController(rank_class, animated: true)
    }
    
    func goToMemo(){
        
        let memo_class = storyBoard.instantiateViewController(withIdentifier: "MemoViewController") as! MemoViewController
        self.navigationController?.pushViewController(memo_class, animated: true)
    }
}
