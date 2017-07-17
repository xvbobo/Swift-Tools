//
//  VideoViewController.swift
//  Swift-Tools
//
//  Created by 许菠菠 on 2017/6/14.
//  Copyright © 2017年 许菠菠. All rights reserved.
//

import UIKit

class VideoViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var sessionTable : UITableView!
    var contentTextArray = ["《兽血沸腾2》是网络作家静官在经历数年前被禁风波之后，改换《兽血沸腾》的西幻体系[1]  ，将穿越定位在东方魔/玄幻的新作，于2014年1月15日登陆纵横中文网","静官，真名马红俊，厨师、作家，毕业于扬州英才烹饪学校。","姓名：静官别名：马红俊国籍：中国民族：汉族出生地：扬州出生日期：1981年","一名牺牲在南疆战场上的中国侦察兵，神奇地在异时空中重生，意外成了兽人王国的萨满祭祀，而且是千年难得一见的龙祭祀!同时身中了最 恶毒的魔宠的血之祭奠的诅咒!","看05年新晋文字玩家静官怎样把一场艳福无边的奇幻冒险写的丰满圆满，看我们的主角怎么去面对自己的新的身份，用高亢的兽人战歌去挑战强大人类的魔法、无敌的军团，以双龙祭祀的身份大败龙骑士!带领从辉煌的光环中逐渐黯澹的比蒙勇士们，与异族侵略者的较量中，如何书写出一段零死亡的传奇!"]
    var timeSring = ["1分钟前","3天前","一星期前","一个月前"]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "视频"
        createTableView()
        showRightItem(itemString: "拍摄")
        // Do any additional setup after loading the view.
    }

    func createTableView() {
        sessionTable = UITableView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
        sessionTable.delegate = self
        sessionTable.dataSource = self
        sessionTable.register(SessionTableViewCell.classForCoder(), forCellReuseIdentifier: "session")
         sessionTable.register(SessionHeaderCell.classForCoder(), forCellReuseIdentifier: "headerCell")
        sessionTable.separatorStyle = .none
        view.addSubview(sessionTable)
    }
    
    override func rigthBatItemAcion() {
        super.rigthBatItemAcion()
        let alertController = UIAlertController(title: nil, message:nil,
                                                preferredStyle: .actionSheet)
        let photoAction = UIAlertAction(title: "相册", style: .destructive, handler: { action in
            let nav = UINavigationController.init(rootViewController: AblumViewController())

           self.present(nav, animated: true, completion: nil)
        })
        let cameraAction = UIAlertAction(title: "拍摄（照片或视频）", style: .default, handler: { action in
            let viedoRecoder = VideoRecoderViewController()
            self.present(viedoRecoder, animated: true, completion: nil)
        })
        alertController.addAction(photoAction)
        alertController.addAction(cameraAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    //tableViewDataSoucre and delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentTextArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "session") as! SessionTableViewCell
            return 60 + cell.countTheLabelOfHeight(text: contentTextArray[indexPath.row - 1])
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! SessionHeaderCell
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "session") as! SessionTableViewCell
            cell.updateSessionCell(text: contentTextArray[indexPath.row - 1] ,time: timeSring[indexPath.row - 1])
            return cell
        }
        
    }
    override func backToUpView() {
        self.dismiss(animated: true, completion: nil)
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
