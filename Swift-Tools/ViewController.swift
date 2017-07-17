//
//  ViewController.swift
//  Swift-Tools
//
//  Created by 许菠菠 on 2017/6/5.
//  Copyright © 2017年 许菠菠. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    var myTableView = UITableView()
    var dataSource = [String]()
    var dataViewControllers = [UIViewController]()
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView = UITableView.init(frame: self.view.frame, style: .plain)
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        dataSource = ["3D旋转","录音","朋友圈","视频播放"]
        dataViewControllers = [FirstViewController(),RecordMusicViewController(),VideoViewController(),VideoPlayerViewController()]
        self.view.addSubview(myTableView)
        // Do any additional setup after loading the view, typically from a nib.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = dataSource[indexPath.row];
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nav = UINavigationController.init(rootViewController: dataViewControllers[indexPath.row])
        
        self.present(nav, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

