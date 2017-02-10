//
//  ResultViewController.swift
//  WTW
//
//  Created by wuttiTARN♡ on 2/9/2560 BE.
//  Copyright © 2560 wphTarn. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var text_score: UITextField!
    
    @IBOutlet weak var congrat_collectionView: UICollectionView!
    
    @IBAction func btn_playagain(_ sender: Any) {
    }
    @IBAction func btn_memo(_ sender: Any) {
    }
    @IBAction func btn_share(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
