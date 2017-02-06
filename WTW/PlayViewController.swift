//
//  PlayViewController.swift
//  WTW
//
//  Created by wuttiTARN♡ on 1/30/2560 BE.
//  Copyright © 2560 wphTarn. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    
    var itemIndex:Int = 3
    var isStopped:Bool = false
    
    ///
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pausePopup: UIView!
    @IBOutlet weak var bg_playmode: UIImageView!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        self.setCollectionView()
        bg_playmode.image = UIImage(named:"playmode")
    }
    
    func setCollectionView(){
        
        collectionView.register(Play_CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        _ = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.moveCollectionCell), userInfo: nil, repeats: true);
    }
    
    func moveCollectionCell() {
        
        if (itemIndex < 300 && isStopped == false){
            self.collectionView?.scrollToItem(at: //scroll collection view to indexpath
                NSIndexPath.init(row:itemIndex, //get last item of self collectionview (number of items -1)
                    section: 0) as IndexPath //scroll to bottom of current section
                , at: UICollectionViewScrollPosition.bottom, //right, left, top, bottom, centeredHorizontally, centeredVertically
                animated: true)
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
