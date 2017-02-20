//
//  PlayController.swift
//  WTW
//
//  Created by pimpaporn chaichompoo on 2/8/17.
//  Copyright © 2017 wphTarn. All rights reserved.
//

import UIKit
import Firebase

class PlayModel: IPlay {
    
    var ref = FIRDatabase.database().reference()
    
    var dic_vocab:NSMutableDictionary = NSMutableDictionary()
    var vocab_count:Int! = 0
    
    var dic_image_vocab:NSMutableDictionary = NSMutableDictionary()
    var dic_image_vocab_count:Int! = 0
    
    func getVocabDataWithLevel(level:Int){
        
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
}
