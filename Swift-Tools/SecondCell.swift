//
//  SecondCell.swift
//  Swift-Tools
//
//  Created by 许菠菠 on 2017/7/18.
//  Copyright © 2017年 许菠菠. All rights reserved.
//

import UIKit

class SecondCell: UITableViewCell {

    var imageView0: UIImageView!
    let imageHelp =  ImageViewHelp()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageView0 = UIImageView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
        self.addSubview(imageView0)
    }
    
    func updateSecondCell(imageString: String , size: CGSize) {
        imageView0.frame.size = size
        self.imageHelp.setImage(urlString: imageString, imageView: imageView0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
