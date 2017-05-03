//
//  MemoViewController.swift
//  WTW
//
//  Created by wuttiTARN♡ on 2/1/2560 BE.
//  Copyright © 2560 wphTarn. All rights reserved.
//

import UIKit

class MemoViewController: UIViewController {
    
    @IBAction func btn_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var image_default: UIImageView!
    var memo_array:NSMutableArray = NSMutableArray()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setUI()
    }
    
    func getData() {
        
        
        let get_memo_info = UserDefaults.standard.value(forKey: "MEMO_INFO")
        print("get memo info",get_memo_info)
        if (get_memo_info != nil){
            //memo_array = get_memo_info as! NSMutableArray
            memo_array = get_memo_info as! NSMutableArray
        }
        print(memo_array)
        self.tableView?.register(UINib(nibName:"MemoTableViewCell" as String, bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    func setUI() {
        
        self.image_default.isHidden = true
        self.tableView.separatorColor = UIColor.clear
        self.tableView.backgroundColor = UIColor.clear
    }
    
}


extension MemoViewController: UITableViewDelegate,UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if(self.memo_array.count == 0){
            self.image_default.isHidden = false
        }
        
        return self.memo_array.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell:MemoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MemoTableViewCell
        var memo_dic:NSDictionary = NSDictionary()
        memo_dic = memo_array[indexPath.row] as! NSDictionary
        let memo_name:String = String(format:"%@",memo_dic["name"] as! String)
        let memo_des:String = String(format:"%@",memo_dic["des"] as! String)
        let memo_img:String = String(format:"%@",memo_dic["image"] as! String)

        
        cell.memo_name.text = memo_name
        cell.memo_des.text = memo_des
        cell.memo_image.kf.setImage(with: URL(string:memo_img));

        return cell
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 104.0
    }

}
