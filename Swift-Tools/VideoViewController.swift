//
//  VideoViewController.swift
//  Swift-Tools
//
//  Created by 许菠菠 on 2017/6/14.
//  Copyright © 2017年 许菠菠. All rights reserved.
//

import UIKit

class VideoViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "视频"
        showRightItem(itemString: "拍摄")
        // Do any additional setup after loading the view.
    }

    override func rigthBatItemAcion() {
        super.rigthBatItemAcion()
        let alertController = UIAlertController(title: nil, message:nil,
                                                preferredStyle: .actionSheet)
        let photoAction = UIAlertAction(title: "相册", style: .destructive, handler: { action in
            let nav = UINavigationController.init(rootViewController: AblumViewController())

           self.present(nav, animated: true, completion: nil)
        })
        let cameraAction = UIAlertAction(title: "相机", style: .default, handler: { action in
            print("相机")
        })
        alertController.addAction(photoAction)
        alertController.addAction(cameraAction)
        self.present(alertController, animated: true, completion: nil)
//        let viedoRecoder = VideoRecoderViewController()
//        self.present(viedoRecoder, animated: true, completion: nil)
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
