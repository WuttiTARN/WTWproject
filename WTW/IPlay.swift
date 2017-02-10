//
//  PlayModel.swift
//  WTW
//
//  Created by pimpaporn chaichompoo on 2/8/17.
//  Copyright © 2017 wphTarn. All rights reserved.
//

import UIKit
import Foundation

protocol IPlay {
    
    func getVocab(index:Int,key:String) -> Any
    func getImagesVocab(index:Int) -> NSMutableDictionary
    func getVocabDataWithLevel(level:Int)
    func randomIndexOfRandomImage() -> NSMutableArray
    func getImageVocabWithId(id:Int) -> String
}

