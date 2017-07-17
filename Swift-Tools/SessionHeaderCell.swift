//
//  SessionHeaderCell.swift
//  Swift-Tools
//
//  Created by 许菠菠 on 2017/7/7.
//  Copyright © 2017年 许菠菠. All rights reserved.
//

import UIKit

class SessionHeaderCell: UITableViewCell {
    
    let cellW = UIScreen.main.bounds.width
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createCellUI()
    }
    
    func createCellUI() {
        let backImage = UIImageView(frame: CGRect(x: 0, y: 0, width: cellW, height: 150))
        backImage.image = UIImage(named: "session_header_image")
        self.addSubview(backImage)
        
        let headerImage = UIImageView(frame: CGRect(x: cellW - 60, y: 120, width: 50, height: 50))
        headerImage.image = UIImage(named: "tiantiansifangmao-4")
        backImage.addSubview(headerImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
