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

    var dic_db:NSMutableDictionary = NSMutableDictionary()
    var ref = FIRDatabase.database().reference()
    
    var dic_vocab:NSMutableDictionary = NSMutableDictionary()
    var vocab_count:Int! = 0
    
    var dic_image_vocab:NSMutableDictionary = NSMutableDictionary()
    var dic_image_vocab_count:Int! = 0

    func getVocabDataWithLevel(level:Int){
        
        let str_level:String!
        
        if (level == 0){
            str_level = "Easy"
        }else if (level == 1){
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
            self.dic_db = sub_vocab_data[str_level] as! NSMutableDictionary
            
            print("get vocab data ",self.dic_db)
        }
    }
    
    func getIDVocab(index:Int) -> Int {
        
        let key_index:String = String(format:"vocab%d",index)
        let dic_vocab_with_index:NSMutableDictionary = dic_vocab[key_index] as! NSMutableDictionary
        
        let vocab_id = dic_vocab_with_index["id"]
        
        return vocab_id as! Int
    }
}
