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

class PlayViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pausePopup: UIView!
    @IBOutlet weak var bg_playmode: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var tx_vocab: UILabel!
    @IBOutlet weak var tx_point: UILabel!
    
    var itemIndex:Int = 3
    var isStopped:Bool = false
    
    var current: Int = 0
    var play_level: Int = 0
    
    var play_model:PlayModel = PlayModel()
    
    var progressBarTimer:Timer!
    var time:Double = 0.0
    
    var alreadyCall:Bool = false
    
    var image_array:NSMutableArray! = NSMutableArray()
    
    var id_vocab:Int = 0
    var sum_point:Int = 0
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 120, animations: { () -> Void in
            self.progressBar.setProgress(1.0, animated: true)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        set_ui()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.setDataVocabToModel(_:)), name: NSNotification.Name(rawValue: "SET_VOCAB"), object: nil)
    }
    
    func setDataVocabToModel(_ notification: NSNotification) {
        
        if (alreadyCall == false){
            
            alreadyCall = true
            
            print("images ",play_model.getImagesVocab(index: 1))
            
            var i:Int = 1
            
            for _ in 1...13 {
                
                let dic_vocab_image:NSMutableDictionary = play_model.getImagesVocab(index: i)
                
                var j:Int = 1
                
                for _ in dic_vocab_image{
                    
                    // %@ = String %d = Int %f = Double,Float
                    
                    let key_image:String = String(format: "image%d", j )
                    
                    let new_image_with_id:NSMutableDictionary! = NSMutableDictionary()
                    
                    new_image_with_id.setValue(dic_vocab_image[key_image], forKey: "image")
                    new_image_with_id.setValue(play_model.getVocab(index: i,key: "id") as! Int, forKey: "id")
                    
                    /*
                     
                     new_image_with_id =
                     
                     { "image" : "http://......",
                        "id" : "1"
                     }
                     
                    */
                    
                    image_array.add(new_image_with_id)
                    
                    j = j+1
                }
                i = i+1
            }
            
            tx_vocab.text = play_model.getVocab(index: 1,key: "name") as? String
            id_vocab = play_model.getVocab(index: 1,key: "id") as! Int
            image_array = randomArray(old_array:image_array)

            _ = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.moveCollectionCell), userInfo: nil, repeats: true);
            
            self.collectionView.reloadData()
        }
    }
    
    func set_play_level(level:Int){
        play_level = level
        play_model.getVocabDataWithLevel(level: level)
    }
    
    func set_ui(){
        
        setCollectionView()
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 10)
    }
    
    func setProgress() {
        
        time = time + 0.1
        progressBar.setProgress(Float(Int(time / 120.0)), animated: true)
        if time >= 120 {
            progressBarTimer!.invalidate()
        }
    }
    
    func updateProgressBar(){
        
        self.progressBar.progress += 0.0018
        if(self.progressBar.progress == 1){
            progressBarTimer.invalidate()
            self.progressBar.removeFromSuperview()
        }
    }
    
    func setCollectionView(){
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(Play_CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(UINib(nibName:"Play_CollectionViewCell",bundle:nil), forCellWithReuseIdentifier: "Cell")
    }
    
    func moveCollectionCell() {
        
        if (itemIndex < image_array.count && isStopped == false){
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
}

extension PlayViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return image_array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell:Play_CollectionViewCell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Play_CollectionViewCell
        cell.setImageCell(image_array:image_array[indexPath.row] as! NSMutableDictionary)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dic_vocab_selected:NSMutableDictionary =  image_array[indexPath.row] as! NSMutableDictionary
        let selected_image_id:Int = dic_vocab_selected["id"] as! Int
        
        if(id_vocab == selected_image_id){
            self.tx_point.text = String(format: "%d", sum_point + 1)
            sum_point = sum_point+1
        }
    }
}
