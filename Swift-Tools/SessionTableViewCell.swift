//
//  SessionTableViewCell.swift
//  Swift-Tools
//
//  Created by 许菠菠 on 2017/7/6.
//  Copyright © 2017年 许菠菠. All rights reserved.
//

import UIKit

class SessionTableViewCell: UITableViewCell {

    var contentLabel : UILabel!
    var timeLabel : UILabel!
    var lineImage : UIImageView!
    
    let contentLabelW = UIScreen.main.bounds.width - 60 - 20;
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        createCellUI()
    }
    
    func createCellUI() {
        let headerImage = UIImageView(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
        headerImage.image = UIImage(named: "tiantiansifangmao-4")
        self.addSubview(headerImage)
        let nameLabel = UILabel(frame: CGRect(x: headerImage.frame.origin.x + headerImage.frame.width + 5, y: 10, width: 200, height: 15))
        nameLabel.text = "小泽玛利亚"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        nameLabel.textColor = .black
        self.addSubview(nameLabel)
        
        
        contentLabel = UILabel(frame: CGRect(x: headerImage.frame.origin.x + headerImage.frame.width + 5, y: nameLabel.frame.origin.y + nameLabel.frame.height + 5, width: contentLabelW, height: 15))
        contentLabel.font = UIFont.boldSystemFont(ofSize: 12)
        contentLabel.textColor = .gray
        contentLabel.numberOfLines = 0
        self.addSubview(contentLabel)
        
        timeLabel = UILabel(frame: CGRect(x: headerImage.frame.origin.x + headerImage.frame.width + 5, y: contentLabel.frame.origin.y + contentLabel.frame.height, width: 100, height: 15))
        timeLabel.font = UIFont.boldSystemFont(ofSize: 12)
        timeLabel.textColor = .lightGray
        self.addSubview(timeLabel)
        
        lineImage = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.5))
        lineImage.backgroundColor = .gray
        self.addSubview(lineImage)
        
        
    }
    
    func updateSessionCell(text: String , time:String) {
        contentLabel.frame.size = CGSize(width: contentLabelW, height: countTheLabelOfHeight(text: text))
        timeLabel.frame.origin = CGPoint(x: timeLabel.frame.origin.x, y: contentLabel.frame.origin.y + contentLabel.frame.height + 10)
        lineImage.frame.origin = CGPoint(x: 0, y: timeLabel.frame.origin.y + timeLabel.frame.height + 10)
        contentLabel.text = text
        timeLabel.text = time
    }
    
    func countTheLabelOfHeight(text: String) -> CGFloat {
        let height = text.heightWithConstrainedWidth(width: contentLabel.frame.width, font: UIFont.systemFont(ofSize: 12))
        return height
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.height
    }
}
