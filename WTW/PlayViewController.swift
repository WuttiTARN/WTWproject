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
    @IBOutlet weak var bg_playmode: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var tx_vocab: UILabel!
    @IBOutlet weak var tx_point: UILabel!
    @IBOutlet weak var tx_vocab_num: UILabel!
    @IBOutlet weak var tx_vocab_level: UILabel!
    @IBOutlet weak var status_bg: UIImageView!
    @IBOutlet weak var view_pause: UIView!
    @IBOutlet weak var view_black: UIView!
    @IBOutlet weak var tx_view_black: UILabel!
    @IBOutlet weak var btn_resume: UIButton!
    
    var vocab_num:Int = 1
    
    var itemIndex:Int = 0
    var isStopped:Bool = false
    
    var current: Int = 0
    var play_level: Int = 0
    
    var play_model:PlayModel = PlayModel()
    
    var progressBarTimer:Timer!
    var time:Double = 0.0
    
    var finishedSetData:Bool = false
    
    var image_array:NSMutableArray! = NSMutableArray()
    
    var id_vocab:Int = 0
    var id_image:Int = 0
    var sum_point:Int = 0
    var id_image_data:Int = 0
    
    var target_time:Int = 12
    var index_vocab:Int = 2
    var array_color:NSMutableArray = NSMutableArray()


    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = false
        
        setCollectionView()
        
        reload_data()
        set_ui()
    }
    
    func reload_data(){
        
        if(finishedSetData == true){
            setDataVocab()
        }else{
            self.perform(#selector(PlayViewController.reload_data) , with: nil, afterDelay: 2)
        }
    }
    
    func setDataVocab(){
        
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
                array_color.add(UIColor.clear)
                j = j+1
            }
            
            image_random_array = randomArray(old_array:image_random_array)
            image_array.addObjects(from:image_random_array as [AnyObject])
            
            i = i+1
        }
        
        print("finished")
        self.collectionView.reloadData()
        self.perform(#selector(callAnimation), with: nil, afterDelay: 0)
    }
    func setDataVocabToModel(_ notification: NSNotification) {
        
        if (finishedSetData == false){
            finishedSetData = true
        }
    }
    
    func callAnimation(){
        
        _ = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.moveCollectionCell), userInfo: nil, repeats: true);
    }
    
    func setVocabAndId(index:Int,vocab_number:Int) {
        
        tx_vocab_num.text = play_model.getVocabIndex(vocab_number: vocab_number)
        tx_vocab.text = play_model.getVocab(index: index,key: "name") as? String
        id_vocab = play_model.getVocab(index: index,key: "id") as! Int
    }
    
    func set_play_level(level:Int){
        
        play_level = level
        NotificationCenter.default.addObserver(self, selector: #selector(self.setDataVocabToModel(_:)), name: NSNotification.Name(rawValue: "SET_VOCAB"), object: nil)
        let set_play_level = play_model.getVocabDataWithLevel(level: level)
        print("set play level = ",set_play_level)
    }
    
    func set_ui(){
        
        self.progressBar.transform = self.progressBar.transform.scaledBy(x: 1, y: 10)
        self.progressBar.layer.cornerRadius = 5.0
        self.progressBar.clipsToBounds = true
        
        self.view_pause.isHidden = true
        self.view_black.isHidden = false
        self.tx_view_black.isHidden = false
        self.tx_view_black.alpha = 0
        
        if (play_level == 1){
            self.tx_vocab_level.text = "EASY"
            self.tx_vocab_level.textColor = UIColor(red: (150/255.0), green: (116/255.0), blue: (6/255.0), alpha: 1.0)
            self.status_bg.image = UIImage(named: "status_easy")
            self.tx_vocab_num.textColor = UIColor(red: (150/255.0), green: (116/255.0), blue: (6/255.0), alpha: 1.0)
            self.tx_point.textColor = UIColor(red: (150/255.0), green: (116/255.0), blue: (6/255.0), alpha: 1.0)
            //progress bar
            progressBar.trackTintColor = UIColor(red: (237/255.0), green: (198/255.0), blue: (39/255.0), alpha: 1.0)
            progressBar.progressTintColor = UIColor(red: (150/255.0), green: (116/255.0), blue: (6/255.0), alpha: 1.0)
            //pause button
            btn_resume.setImage(#imageLiteral(resourceName: "btn_pauseEasy"),for:UIControlState.normal)
            
            
        }else if(play_level == 2){
            self.tx_vocab_level.text = "MEDIUM"
            self.tx_vocab_level.textColor = UIColor(red: (208/255.0), green: (247/255.0), blue: (254/255.0), alpha: 1.0)
            self.status_bg.image = UIImage(named: "status_medium")
            self.tx_vocab_num.textColor = UIColor(red: (208/255.0), green: (247/255.0), blue: (254/255.0), alpha: 1.0)
            self.tx_point.textColor = UIColor(red: (255/255.0), green: (255/255.0), blue: (255/255.0), alpha: 1.0)
            //progress bar
            progressBar.trackTintColor = UIColor(red: (208/255.0), green: (247/255.0), blue: (254/255.0), alpha: 1.0)
            progressBar.progressTintColor = UIColor(red: (13/255.0), green: (122/255.0), blue: (172/255.0), alpha: 1.0)
            //pause button
            btn_resume.setImage(#imageLiteral(resourceName: "btn_pauseMedium"),for:UIControlState.normal)
        }else{
            self.tx_vocab_level.text = "HARD"
            self.tx_vocab_level.textColor = UIColor(red: (220/255.0), green: (248/255.0), blue: (0/255.0), alpha: 1.0)
            self.status_bg.image = UIImage(named: "status_hard")
            self.tx_vocab_num.textColor = UIColor(red: (220/255.0), green: (248/255.0), blue: (0/255.0), alpha: 1.0)
            self.tx_point.textColor = UIColor(red: (255/255.0), green: (255/255.0), blue: (255/255.0), alpha: 1.0)
            //progress bar
            progressBar.trackTintColor = UIColor(red: (220/255.0), green: (248/255.0), blue: (0/255.0), alpha: 1.0)
            progressBar.progressTintColor = UIColor(red: (50/255.0), green: (107/255.0), blue: (24/255.0), alpha: 1.0)
            //pause button
            btn_resume.setImage(#imageLiteral(resourceName: "btn_pauseHard"),for:UIControlState.normal)
            
        }
        count_number()
    }
    
    func count_number(){
        
        self.tx_view_black.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            
            self.tx_view_black.text = "3"
            self.tx_view_black.alpha = 1
            self.view.layoutIfNeeded()
            
        }, completion: { (finished: Bool) in
            
            self.tx_view_black.alpha = 0
            UIView.animate(withDuration: 1, animations: {
                
                self.tx_view_black.font = UIFont(name: "Nickname DEMO", size: 250.0)
                self.tx_view_black.text = "2"
                self.tx_view_black.alpha = 1
                self.view.layoutIfNeeded()
                
            }, completion: { (finished: Bool) in
                
                self.tx_view_black.alpha = 0
                UIView.animate(withDuration: 1, animations: {
                    
                    self.tx_view_black.font = UIFont(name: "Nickname DEMO", size: 180.0)
                    self.tx_view_black.text = "1"
                    self.tx_view_black.alpha = 1
                    self.view.layoutIfNeeded()
                    
                }, completion: { (finished: Bool) in
                    
                    self.view_black.isHidden = true
                    
                    self.setVocabAndId(index: 1,vocab_number:self.vocab_num)
                    
                    self.progressBarTimer = self.setTimer()
                })
            })
        })
    }
    
    func setTimer() -> Timer{
        
        return Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:#selector(self.setProgress), userInfo: nil, repeats: true)
    }
    
    func setProgress() {
        
        time += 0.1
        progressBar.setProgress(Float(time / 120.0), animated: true)
        
        if play_model.changeVocab(target_time:target_time,current_time:Int(time)) == true {
            
            vocab_num = play_model.getIndexVocabByTime(time: Int(time))
            //play_model.updateVocabNumber(vocab_number: vocab_num)
            
            setVocabAndId(index: index_vocab,vocab_number:vocab_num)
            index_vocab = play_model.updateIndexVocab(index: index_vocab)
            target_time = play_model.updateTargetTime(time: target_time)
        }
        
        if time >= 120 {
            
            self.view_black.isHidden = false
            self.view_pause.isHidden = true
            
            self.tx_view_black.font = UIFont(name: "Nickname DEMO", size: 50.0)
            self.tx_view_black.text = "time's up"
            
            progressBarTimer!.invalidate() // cancel count progressBarTimer
            updateHightScore()
            
            self.perform(#selector(self.gotoResultWithPoint), with: nil, afterDelay: 2)
        }
    }
    
    func gotoResultWithPoint(){
        
        self.goToResult(point: tx_point.text! as String)
    }
    
    func setCollectionView(){
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(Play_CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(UINib(nibName:"Play_CollectionViewCell",bundle:nil), forCellWithReuseIdentifier: "Cell")
    }
    
    func moveCollectionCell() {
        
        self.view.isUserInteractionEnabled = true
        
        if (itemIndex < image_array.count && isStopped == false){
            
            self.collectionView?.scrollToItem(at:NSIndexPath.init(row:itemIndex,section: 0) as IndexPath
                , at: UICollectionViewScrollPosition.bottom,animated: true)
            itemIndex = itemIndex + 3
        }
    }
    
    @IBAction func btnStopPressed(sender: UIButton) {
        
        isStopped = true
        self.tx_view_black.isHidden = true
        self.view_pause.isHidden = false
        self.view_black.isHidden = false
        progressBarTimer!.invalidate()
    }
    
    @IBAction func btnResumePressed(_ sender: Any) {
        
        isStopped = false
        self.view_black.isHidden = true
        self.progressBarTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:#selector(PlayViewController.setProgress), userInfo: nil, repeats: true)
    }
    
    @IBAction func btnNewGamePressed(_ sender: Any) {
        progressBarTimer!.invalidate()
        updateHightScore()
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func prepareForReuse(){
    }
    
    func updateHightScore(){
        
        let user_info = UserDefaults.standard.value(forKey: "USER_INFO") as! [String:Any]
        let updateUserInfo = ["id":user_info["id"] as! Int,
                              "high_score":Int(self.tx_point.text!)!,
                              "image":user_info["image"] as! String,
                              "name":user_info["name"] as! String] as [String:Any]
        
        play_model.setInfo(user_info: updateUserInfo, key:user_info["id"] as! Int)
    }
}

extension PlayViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return image_array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell:Play_CollectionViewCell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Play_CollectionViewCell
        cell.setImageCell(image_array:image_array[indexPath.row] as! NSMutableDictionary)
        cell.backgroundColor = array_color[indexPath.row] as? UIColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dic_vocab_selected:NSMutableDictionary =  image_array[indexPath.row] as! NSMutableDictionary
        let selected_image_id:Int = dic_vocab_selected["id_vocab"] as! Int
        let selected_image:String = play_model.getImageVocabWithId(id: id_vocab)
        
        id_image = dic_vocab_selected["id_image"] as! Int
        
        if (id_image != id_image_data){ // กดไม่ซ้ำ
            
            id_image_data = id_image
            
            if play_model.verifyResult(id_correct_vocab: id_vocab, id_selected_image: selected_image_id, selected_image: selected_image) == true {
                
                self.tx_point.text = String(format: "%d", sum_point + 10)
                sum_point = sum_point+10
                array_color.replaceObject(at: indexPath.row, with: UIColor.green)
                collectionView.reloadData()
                
            }else{
                
                if (sum_point >= 10){
                    self.tx_point.text = String(format: "%d", sum_point - 10)
                    sum_point = sum_point-10
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        play_model.saveMemoArray()
    }
}
