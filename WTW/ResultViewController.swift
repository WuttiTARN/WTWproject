//
//  ResultViewController.swift
//  WTW
//
//  Created by wuttiTARN♡ on 2/9/2560 BE.
//  Copyright © 2560 wphTarn. All rights reserved.
//

import UIKit

class ResultViewController: BaseViewController {
    
    @IBOutlet weak var text_score: UITextField!
    
    @IBOutlet weak var img_congrat: UIImageView!
    
    var point:String = " "

    override func viewDidLoad() {
        super.viewDidLoad()
        setPoint(point: point)
    }
    
    func setPoint(point:String){
        
        print("point = ",point)
        
        let num_point:Int = Int(point)!
        
        if(num_point >= 700 && num_point <= 1500){
            self.img_congrat.image = UIImage(named: "twoStars")
            text_score.text = "\(num_point)"
        }else if(num_point > 1500){
            self.img_congrat.image = UIImage(named: "threeStars")
            text_score.text = "\(num_point)"
        }else{
            text_score.text = "\(num_point)"
            self.img_congrat.image = UIImage(named: "oneStar")
        }
    }
    
    @IBAction func btn_playagain(_ sender: Any) {
        goToMainClass()
    }
    @IBAction func btn_memo(_ sender: Any) {
        goToMemo()
    }
    @IBAction func btn_share(_ sender: Any) {
        
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
