//
//  VideoPlayerViewController.swift
//  Swift-Tools
//
//  Created by 许菠菠 on 2017/7/11.
//  Copyright © 2017年 许菠菠. All rights reserved.
//

import UIKit

class VideoPlayerViewController: BaseViewController {
    var segmentView : SegementView!
    var playerView : CustomAVPlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentView = SegementView(frame: CGRect(x: 0, y: 64, width:UIScreen.main.bounds.width , height: 50))
        segmentView.createSegmentUI(buttonTitlesArray: ["录制","播放网络视频(本地视频需要自己导入)","暂停"])
        view.addSubview(segmentView)
        
        playerView = CustomAVPlayerView(frame: CGRect(x: 0, y: segmentView.frame.origin.y + segmentView.frame.size.height, width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/3 * 2))
//        guard let path = Bundle.main.path(forResource: "IMG_0865", ofType: ".mp4") else {
//            fatalError("视频错误")
//        }
        
//        playerView.videoURL(videoSring: path)
        //播放本地视频
        view.addSubview(playerView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func backToUpView() {
        self.dismiss(animated: true, completion: nil)
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
