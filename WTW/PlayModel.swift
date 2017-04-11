//
//  PlayController.swift
//  WTW
//
//  Created by wuttiTARN♡ on 1/30/2560 BE.
//  Copyright © 2017 wphTarn. All rights reserved.
//

import UIKit
import Firebase

class PlayModel: NSObject {
    
    var ref = FIRDatabase.database().reference()
    
    var baseClass:BaseViewController = BaseViewController()
    
    var memo_array:NSMutableArray! = NSMutableArray()
    var dic_vocab:NSMutableDictionary = NSMutableDictionary()
    var vocab_count:Int! = 0
    
    var dic_image_vocab:NSMutableDictionary = NSMutableDictionary()
    var dic_image_vocab_count:Int! = 0
    
    func changeVocab(target_time:Int,current_time:Int) -> Bool {
        
        if(current_time > target_time){
            return true
        }
        return false
    }
    
    func updateVocabNumber(vocab_number:Int) -> Int {
        return vocab_number+1
    }
    
    func updateIndexVocab(index:Int) -> Int {
        return index+1
    }
    
    func updateTargetTime(time:Int) -> Int {
        return time+12
    }
    
    func getVocabIndex(vocab_number:Int) -> String {
        return String(format: "%d/10",vocab_number)
    }
    
    func getIndexVocabByTime(time:Int) -> Int{
        let result = Float(time)/120.0
        return Int(result * 10) + 1
    }
    
    func getVocabDataWithLevel(level:Int) -> String{
        
        let str_level:String!
        
        if (level == 1){
            str_level = "Easy"
        }else if (level == 2){
            str_level = "Medium"
        }else{
            str_level = "Hard"
        }
        
        ref.observe(.value) { (snap: FIRDataSnapshot) in
            
            var vocab_data:NSMutableDictionary = NSMutableDictionary()
            vocab_data = (snap.value as! NSMutableDictionary).mutableCopy() as! NSMutableDictionary
            let sub_vocab_data:NSMutableDictionary = vocab_data["Vocabularies"] as! NSMutableDictionary
            
            self.dic_vocab = (sub_vocab_data[str_level] as! NSMutableDictionary)
            self.vocab_count = (sub_vocab_data[str_level] as! NSMutableDictionary).count
            
            //            print("get vocab data ",self.dic_vocab)
            NotificationCenter.default.post(name:NSNotification.Name(rawValue: "SET_VOCAB"), object: nil)
        }
        
        return str_level
    }
    
    func getVocab(index:Int,key:String) -> Any {
        
        let key_index:String = String(format:"vocab%d",index)
        
        if (dic_vocab[key_index] != nil){
            let dic_vocab_with_index:NSMutableDictionary = dic_vocab[key_index] as! NSMutableDictionary
            
            let vocab_id = dic_vocab_with_index[key]
            return vocab_id as Any
        }else{
            return 1
        }
    }
    
    func getImagesVocab(index:Int) -> NSMutableDictionary{
        
        let key_index:String = String(format:"vocab%d",index)
        let dic_vocab_with_index:NSMutableDictionary = dic_vocab[key_index] as! NSMutableDictionary
        
        return dic_vocab_with_index["images"] as! NSMutableDictionary
    }
    
    func getImageVocabWithId(id:Int) -> String{
        
        let key_index:String = String(format:"vocab%d",id)
        let dic_vocab_with_index:NSMutableDictionary = dic_vocab[key_index] as! NSMutableDictionary
        let images_dic:NSMutableDictionary = dic_vocab_with_index["images"] as! NSMutableDictionary
        
        return images_dic["image1"] as! String
    }
    
    func randomIndexOfRandomImage() -> NSMutableArray {
        
        let base_class = BaseViewController()
        
        var number_array = NSMutableArray()
        var i:Int = 0
        
        for _ in 1...66 {
            number_array.add(i)
            i = i+1
        }
        
        number_array = base_class.randomArray(old_array: number_array)
        return number_array
    }
    
    func setInfo(user_info:[String:Any],key:Int) {
        UserDefaults.standard.set(user_info, forKey: "USER_INFO")
        let new_key = String(format: "user:%d",key)
        let itemRef = self.ref.child("Users").child(new_key)
        itemRef.setValue(user_info)
    }
    
    func verifyResult(id_correct_vocab:Int,id_selected_image:Int,selected_image:String) -> Bool{
        
        if(id_correct_vocab == id_selected_image){ // correct
            
            return true
            
        }else{
            
            var dic_memo_array:NSMutableDictionary = NSMutableDictionary()
            
            if (memo_array.count == 0){
                
                dic_memo_array.setValue(id_correct_vocab, forKey:"id_vocab")
                dic_memo_array.setValue(selected_image, forKey:"image")
                dic_memo_array.setValue(self.getVocab(index: id_correct_vocab, key: "name"), forKey:"name")
                dic_memo_array.setValue(self.getVocab(index: id_correct_vocab, key: "description"), forKey:"des")
                
                memo_array.add(dic_memo_array)
                
            }else{
                
                var i:Int = 0
                var vocab_repeat:Bool = false
                
                for _ in memo_array{
                    
                    dic_memo_array = memo_array[i] as! NSMutableDictionary
                    
                    let id_image_in_memo_array:Int = dic_memo_array["id_vocab"] as! Int
                    
                    if (id_correct_vocab == Int(id_image_in_memo_array)){
                        vocab_repeat = true
                        break
                    }
                    
                    i = i+1
                }
                
                if(vocab_repeat == false){
                    
                    let new_memo_dic:NSMutableDictionary = NSMutableDictionary()
                    new_memo_dic.setValue(id_correct_vocab, forKey:"id_vocab")
                    new_memo_dic.setValue(self.getVocab(index: id_correct_vocab, key: "name"), forKey:"name")
                    new_memo_dic.setValue(self.getVocab(index: id_correct_vocab, key: "description"), forKey:"des")
                    new_memo_dic.setValue(selected_image, forKey:"image")
                    
                    memo_array.add(new_memo_dic)
                }
            }
            return false
        }
    }
    
    func saveMemoArray(){
        UserDefaults.standard.set(memo_array,forKey:"MEMO_INFO")
    }
}
