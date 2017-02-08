//
//  PlayView.swift
//  WTW
//
//  Created by wuttiTARN♡ on 1/30/2560 BE.
//  Copyright © 2560 wphTarn. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth

class PlayViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pausePopup: UIView!
    @IBOutlet weak var bg_playmode: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var itemIndex:Int = 3
    var isStopped:Bool = false
    
    var current: Int = 0
    var play_level: Int = 0
    
    var play_model:PlayModel = PlayModel()
    
    var progressBarTimer:Timer!
    var time:Double = 0.0
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 120, animations: { () -> Void in
            self.progressBar.setProgress(1.0, animated: true)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        set_ui()
    }
    
    func set_play_level(level:Int){
        play_level = level
        play_model.getVocabDataWithLevel(level: level)
    }
    
    func set_ui(){
        
        setCollectionView()
        //ความสูงของ progress bar
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 12)
        self.progressBar.clipsToBounds = true
    }
    
    func setProgress() {
        
        time = time + 0.1
        progressBar.setProgress(Float(Int(time / 120.0)), animated: true)
        if time >= 120 {
            progressBarTimer!.invalidate()
        }
    }
    
    func updateProgressBar(){
        
        self.progressBar.progress += 0.0012
        if(self.progressBar.progress == 1){
            progressBarTimer.invalidate()
            self.progressBar.removeFromSuperview()
        }
    }
    
    func setCollectionView(){
        
        collectionView.register(Play_CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        _ = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.moveCollectionCell), userInfo: nil, repeats: true);
    }
    
    func moveCollectionCell() {
        
        if (itemIndex < 300 && isStopped == false){
            self.collectionView?.scrollToItem(at:NSIndexPath.init(row:itemIndex,section: 0) as IndexPath
                , at: UICollectionViewScrollPosition.bottom,animated: true)
            itemIndex = itemIndex + 3
        }
    }
    
    @IBAction func btnStopPressed(_ sender: Any) {
        
        isStopped = true
        self.pausePopup.isHidden = false
    }
    
    @IBAction func btnResumePressed(_ sender: Any) {
        
        isStopped = false
        self.pausePopup.isHidden = true
    }
    
    @IBAction func btnNewGamePressed(_ sender: Any) {
   
        _ = navigationController?.popViewController(animated: true)
    }
    
}

extension PlayViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 300
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell:Play_CollectionViewCell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Play_CollectionViewCell
        
        cell.backgroundColor = UIColor.blue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
