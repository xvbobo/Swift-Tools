//
//  PhotoCollectionViewCell.swift
//  Swift-Tools
//
//  Created by 许菠菠 on 2017/6/21.
//  Copyright © 2017年 许菠菠. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    var imageView : UIImageView!
    let width = (UIScreen.main.bounds.width - 40)/3
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: width, height: width))
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
    }
    func updateImage(image:UIImage) {
        imageView.image = image
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
