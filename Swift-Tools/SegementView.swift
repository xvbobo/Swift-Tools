//
//  SegementView.swift
//  Swift-Tools
//
//  Created by 许菠菠 on 2017/7/11.
//  Copyright © 2017年 许菠菠. All rights reserved.
//

import UIKit

class SegementView: UIView ,UITableViewDelegate,UITableViewDataSource{
    
    var buttonArray = [UIButton]()
    var listView = UITableView()
    var isFist = true
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func createSegmentUI(buttonTitlesArray:[String]) {
        
        let buttonW = UIScreen.main.bounds.width/CGFloat(buttonTitlesArray.count)
        listView = UITableView(frame: CGRect(x: buttonW, y: 50, width: buttonW, height: 150 ), style: .plain)
        listView.separatorStyle = .none
        listView.isHidden = true
        listView.dataSource = self
        listView.delegate = self
        listView.contentInset = UIEdgeInsetsMake(-60, 0, 0, 0)
        listView.scrollIndicatorInsets = UIEdgeInsetsMake(-60, 0, 0, 0);
        listView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "list")
        

        for i in 0..<buttonTitlesArray.count {
            let button = UIButton(type: .custom)
            button.frame = CGRect.init(x: CGFloat(i) * buttonW, y: 0, width: buttonW, height: 50)
            button.setTitle(buttonTitlesArray[i], for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.setTitleColor(.gray, for: .selected)
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.layer.borderWidth = 0.5
            button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
            if i == 0 {
                button.isSelected = true
            }
            button.tag = 100 + i
            buttonArray.append(button)
            self.addSubview(button)
        }
        self.insertSubview(listView, at: 0)
        createTableView()
    }
    
    func createTableView() {
    }
    
    func buttonClick(button:UIButton) {
        for btn in buttonArray {
            if btn.tag == button.tag {
                btn.isSelected = true
            }else{
                btn.isSelected = false
            }
        }
        
        if button.tag - 100 == 1 {
            if isFist == true {
                listView.isHidden = false
                self.frame.size = CGSize(width: self.frame.width, height: 250)

            }else{
                listView.isHidden = true
                self.frame.size = CGSize(width: self.frame.width, height: 50)


            }
            isFist = !isFist

        }else{
            listView.isHidden = true
            self.frame.size = CGSize(width: self.frame.width, height: 50)
        }

    }
    
    //tableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "list")
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
