//
//  BaseViewController.swift
//  Swift-Tools
//
//  Created by 许菠菠 on 2017/6/14.
//  Copyright © 2017年 许菠菠. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let barItem = UIBarButtonItem.init(title: "返回", style: .done, target: self, action: #selector(self.backToUpView))
        barItem.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = barItem
        
        
        // Do any additional setup after loading the view.
    }
    
    func showRightItem(itemString:String) {
       let barItemRight = UIBarButtonItem(title: itemString, style: .done, target: self, action: #selector(self.rigthBatItemAcion))
        barItemRight.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = barItemRight

    }
    
    func backToUpView() {
        
    }

    func rigthBatItemAcion() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
