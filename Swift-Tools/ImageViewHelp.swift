//
//  ImageViewHelp.swift
//  Swift-Tools
//
//  Created by 许菠菠 on 2017/8/3.
//  Copyright © 2017年 许菠菠. All rights reserved.
//

import UIKit

class ImageViewHelp: NSObject {
    
    private var fileManager: FileManager!
    private var subCachePath: String!
    private var cachePath:String!

    
    override init() {
        super.init()
        cachePath = NSHomeDirectory() + "/Documents/imageCach"
        
        self.fileManager = FileManager()
        
        do {
            try self.fileManager.createDirectory(atPath: cachePath, withIntermediateDirectories: true, attributes: nil)
        } catch _ {
            print("创建缓存目录失败")
        }
       

        
       
    }
    
    func setImage(urlString : String , imageView: UIImageView){
        if urlString.isEmpty {
            imageView.image = UIImage(named: "")
            return
        }
        self.getImage(imageString: urlString) { (image) in
            if (image != nil) {
                imageView.image = image
            }else{
               self.saveImage(imageString: urlString,imageView: imageView)
            }
        }
        
        
    }
    
    func saveImage(imageString:String,imageView: UIImageView) {
        DispatchQueue.global().async {
            let pathStr = self.cachePath + "/" + "\(imageString.hash)."+"image"
            let url = URL.init(string: imageString)
            do {
               let data = try Data.init(contentsOf: url!)
                DispatchQueue.main.async {
                    self.fileManager.createFile(atPath: pathStr, contents: data, attributes: nil)
                    let image = UIImage.init(data: data)
                    imageView.image = image
                }

            }catch _ {
               print("图片转化Data失败")
            }
            
        }
    }
    
    func getImage(imageString: String ,imageGetHandler:@escaping(_ image : UIImage?) -> ()){
        let pathStr = self.cachePath + "/" + "\(imageString.hash)."+"image"
        let data =  NSData.init(contentsOfFile: pathStr)
        if  (data != nil) {
            let image = UIImage(data: data! as Data)
            imageGetHandler(image)
        }else{
            imageGetHandler(nil)
            print("本地图片获取失败")
        }
    }
}
