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
    var memo_array:NSMutableArray! = NSMutableArray()
    
    var id_vocab:Int = 0
    var id_image:Int = 0
    var sum_point:Int = 0
    var id_image_data:Int = 0
    
    var target_time:Int = 12
    var index_vocab:Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        set_ui()
    }
    
    func setDataVocabToModel(_ notification: NSNotification) {
        
        if (alreadyCall == false){
            
            alreadyCall = true
            
            var i:Int = 1
            
            for _ in 1...10 {
                
                var image_random_array:NSMutableArray! = NSMutableArray()
                var dic_vocab_image:NSMutableDictionary = play_model.getImagesVocab(index: i)
                
                var j:Int = 1
                
                for _ in 1...51{
                    
                    let new_image_with_id:NSMutableDictionary! = NSMutableDictionary()
                    let key_image:String = String(format: "image%d", j )
                    
                    if (j <= 18){
                        
                        new_image_with_id.setValue(dic_vocab_image[key_image], forKey: "image")
                        new_image_with_id.setValue(play_model.getVocab(index: i,key: "id") as! Int, forKey: "id_vocab")
                        new_image_with_id.setValue(j, forKey: "id_image")
                        
                    }else{
                        
                        dic_vocab_image = play_model.getImagesVocab(index: 13)
                        let random_number_array:NSMutableArray = play_model.randomIndexOfRandomImage()
                        
                        let key_image:String = String(format: "image%d",random_number_array[j] as! Int)
                        
                        new_image_with_id.setValue(dic_vocab_image[key_image], forKey: "image")
                        new_image_with_id.setValue(j , forKey: "id_image")
                        new_image_with_id.setValue(13, forKey: "id_vocab")
                        
                        if(new_image_with_id.count<=2){
                            
                            new_image_with_id.setValue("https://lh4.ggpht.com/Hhn1Nmu5AFboFP8BcJlTIB-VwvJrm69D2CY_bmXEEB35QV9v7kEdFyxE5-SxgPEIoQ=w300", forKey: "image")
                            new_image_with_id.setValue(j , forKey: "id_image")
                            new_image_with_id.setValue(13, forKey: "id_vocab")
                        }
                    }
                    
                    image_random_array.add(new_image_with_id)
                    j = j+1
                }
                
                image_random_array = randomArray(old_array:image_random_array)
                image_array.addObjects(from:image_random_array as [AnyObject])
                
                i = i+1
            }
            
            self.perform(#selector(callAnimation), with: nil, afterDelay: 2)
        }
    }
    
    func callAnimation(){
        
        _ = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.moveCollectionCell), userInfo: nil, repeats: true);
    }
    
    func setVocabAndId(index:Int) {
        
        tx_vocab.text = play_model.getVocab(index: index,key: "name") as? String
        id_vocab = play_model.getVocab(index: index,key: "id") as! Int
    }
    
    func set_play_level(level:Int){
        
        play_level = level
        NotificationCenter.default.addObserver(self, selector: #selector(self.setDataVocabToModel(_:)), name: NSNotification.Name(rawValue: "SET_VOCAB"), object: nil)
        play_model.getVocabDataWithLevel(level: level)
    }
    
    func set_ui(){
        
        setCollectionView()
        
        setVocabAndId(index: 1)
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 10)
        
        progressBarTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:#selector(PlayViewController.setProgress), userInfo: nil, repeats: true)
    }
    
    func setProgress() {
        
        time += 0.1
        
        progressBar.setProgress(Float(time / 120.0), animated: true)
        
        if(Int(time) > target_time){
            
            setVocabAndId(index: index_vocab)
            index_vocab = index_vocab+1
            target_time = target_time + 12
        }
        
        if time >= 120 {
            progressBarTimer!.invalidate()
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
    
    @IBAction func btnNewGamePressed(_ sender: Any) {
        
        _ = self.navigationController?.popViewController(animated: true)
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
        let selected_image_id:Int = dic_vocab_selected["id_vocab"] as! Int
        let selected_image:String = play_model.getImageVocabWithId(id: id_vocab)
        
        id_image = dic_vocab_selected["id_image"] as! Int
        
        if (id_image != id_image_data){
            
            if(id_vocab == selected_image_id){ // correct
                
                self.tx_point.text = String(format: "%d", sum_point + 10)
                sum_point = sum_point+1
                
            }else{
                
                id_image_data = id_image
                var dic_memo_array:NSMutableDictionary = NSMutableDictionary()
                
                if (memo_array.count == 0){
                    
                    dic_memo_array.setValue(id_vocab, forKey:"id_vocab")
                    dic_memo_array.setValue(selected_image, forKey:"image")
                    dic_memo_array.setValue(play_model.getVocab(index: id_vocab, key: "name"), forKey:"name")
                    dic_memo_array.setValue(play_model.getVocab(index: id_vocab, key: "description"), forKey:"des")
                    
                    memo_array.add(dic_memo_array)
                    
                }else{
                    
                    var i:Int = 0
                    var vocab_repeat:Bool = false
                    
                    for _ in memo_array{
                        
                        dic_memo_array = memo_array[i] as! NSMutableDictionary
                        
                        let id_image_in_memo_array:Int = dic_memo_array["id_vocab"] as! Int
                        
                        if (id_vocab == Int(id_image_in_memo_array)){
                            vocab_repeat = true
                            break
                        }
                        
                        i = i+1
                    }
                    
                    if(vocab_repeat == false){
                        
                        let new_memo_dic:NSMutableDictionary = NSMutableDictionary()
                        new_memo_dic.setValue(id_vocab, forKey:"id_vocab")
                        new_memo_dic.setValue(play_model.getVocab(index: id_vocab, key: "name"), forKey:"name")
                        new_memo_dic.setValue(play_model.getVocab(index: id_vocab, key: "description"), forKey:"des")
                        new_memo_dic.setValue(selected_image, forKey:"image")
                        
                        memo_array.add(new_memo_dic)
                    }
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(memo_array,forKey:"MEMO_INFO")
    }
}
