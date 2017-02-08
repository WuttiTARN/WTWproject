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
    
    func getIDVocab(index:Int) -> Int
    func getVocabDataWithLevel(level:Int)
}

