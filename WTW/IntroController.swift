//
//  IntroController.swift
//  WTW
//
//  Created by wuttiTARN♡ on 1/30/2560 BE.
//  Copyright © 2560 wphTarn. All rights reserved.
//

import UIKit

class IntroController: UIViewController,UIScrollViewDelegate {
    
    var color_array:[UIColor]!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var view_header: UIView!
    @IBOutlet weak var page_control: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        color_array = [UIColor.red,UIColor.blue,UIColor.green]
        
        view_header.backgroundColor = color_array[0]
        self.setCollectionView()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageWidth = self.collectionView.frame.size.width
        
        let current_page = Int(self.collectionView.contentOffset.x / pageWidth)
        page_control.currentPage = current_page
        view_header.backgroundColor = color_array[current_page]
        
        if (current_page == 2){
            btnNext.setTitle("Play",for: .normal)
        }else{
            btnNext.setTitle("Skip",for: .normal)
        }
    }
    
    func setCollectionView(){
        collectionView.register(Into_CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
}

extension IntroController:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell:Into_CollectionViewCell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Into_CollectionViewCell
        
        cell.backgroundColor = color_array[indexPath.row]
        
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
