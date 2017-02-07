//
//  IntroController.swift
//  WTW
//
//  Created by wuttiTARN♡ on 1/30/2560 BE.
//  Copyright © 2560 wphTarn. All rights reserved.
//

import UIKit

class IntroController: UIViewController,UIScrollViewDelegate {
    
    
    var current_page:Int = 0
    var image_array:NSArray = ["intro1","intro2","intro3"]
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var view_header: UIView!
    @IBOutlet weak var page_control: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var readyToPlay:Bool = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //view_header.backgroundColor = color_array[0]
        self.setCollectionView()
        }
    
    @IBAction func btnSkipPressed(_ sender: Any) {
        
        goToMainClass()
    }
  
    @IBAction func btnNextPreesed(_ sender: Any) {
        
        if (readyToPlay == true){
            goToMainClass()
        }else{
            
            var index:Int = 0
            
            print("current_page",current_page)
            
            if(current_page == 1){
                index = 1
            }else if(current_page == 2){
                index = 2
            }else{
                goToMainClass()
                return
            }
            
            readyToPlay = false
            let indexPath = IndexPath(row: index, section: 0)
            page_control.currentPage = index
            collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated:true)

        }
    }
    
    func  goToMainClass()  {
        
        UserDefaults.standard.set("NO",forKey:"FIRSTTIME_LAUNCHING")

        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let main_class = storyBoard.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
        self.navigationController?.pushViewController(main_class, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageWidth = self.collectionView.frame.size.width
        
        current_page = Int(self.collectionView.contentOffset.x / pageWidth)
        page_control.currentPage = current_page
        //view_header.backgroundColor = color_array[current_page]
        
        readyToPlay = false
        if (current_page == 2){
            readyToPlay = true
            btnNext.setTitle("Play",for: .normal)
        }else{
            btnNext.setTitle("Next",for: .normal)
        }
    }
    
    func setCollectionView(){
        collectionView.register(Into_CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
}

extension IntroController:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 3
//        image_array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell:Into_CollectionViewCell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Into_CollectionViewCell
        
        print("image ",image_array[indexPath.row])
        cell.setImage(image_name: image_array[indexPath.row] as! String)
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
