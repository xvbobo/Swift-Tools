//
//  CustomAVPlayerView.swift
//  Swift-Tools
//
//  Created by 许菠菠 on 2017/7/14.
//  Copyright © 2017年 许菠菠. All rights reserved.
//

import UIKit
import AVFoundation

class CustomAVPlayerView: UIView {

    //播放进度
    var progress: UIProgressView!
    var videoPlayer : AVPlayer!
    var videoItem : AVPlayerItem!
    var playerLayer : AVPlayerLayer!
    var videoView : UIView!
    var playerBtn : UIButton!
    //时间观察者
    var timeObserver: Any!
    //显示播放时间
    var timeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        playerBtn = customerButton(title: "播放", rect: CGRect(x: 20, y: self.bounds.height - 70, width: 40, height: 40))
        self.addSubview(playerBtn)
        
        progress = UIProgressView(frame: CGRect(x: playerBtn.frame.width + playerBtn.frame.origin.x + 5, y: playerBtn.frame.origin.y + playerBtn.frame.height - 20, width: self.bounds.width - playerBtn.frame.origin.x - playerBtn.frame.size.width - 5 - 60, height: 20))
        progress.progressTintColor = UIColor.blue
        progress.trackTintColor = UIColor.gray
        self.addSubview(progress)
        
        timeLabel = UILabel(frame: CGRect(x: progress.frame.origin.x + progress.frame.width + 5, y: progress.frame.origin.y - 10, width: 60, height: 20))
        timeLabel.text = "13:90"
        timeLabel.font = UIFont.systemFont(ofSize: 12.0)
        timeLabel.textColor = UIColor.white
        self.addSubview(timeLabel)
        
       //        print( videoItem.status)

    }
    
    func videoURL(videoSring: String) {
        videoView = vieoViewCustomer(rect: self.bounds, videoString: videoSring)
        
        self.insertSubview(videoView, belowSubview: playerBtn)

    }
    
    func customerButton(title:String,rect: CGRect) -> UIButton{
        let button = UIButton(type: .custom)
        button.frame = rect
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(customerButtonClick), for: .touchUpInside)
        return button
    }
    
    func customerButtonClick(button:UIButton) {
        print(button.titleLabel?.text ?? "0")
        if let player = videoPlayer {
            if player.rate == 0{//点击时已暂停
                button.setTitle("暂停", for: .normal)
                player.play()
            }else if player.rate == 1{//点击时正在播放
                player.pause()
                button.setTitle("播放", for: .normal)
            }
        }
    }
    
    func vieoViewCustomer(rect: CGRect , videoString: String) -> UIView {
        let view = UIView(frame:rect)
        let url = NSURL(fileURLWithPath: videoString)
        videoItem = AVPlayerItem(url: url as URL) // 创建视频资源
        // 监听缓冲进度改变
        // 将视频资源赋值给视频播放对象
        videoPlayer = AVPlayer(playerItem: videoItem)
        // 初始化视频显示layer
        playerLayer = AVPlayerLayer(player: videoPlayer)
        
        playerLayer.frame = self.bounds;
        // 设置显示模式
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect
        // 赋值给自定义的View
        // 位置放在最底下
        view.layer.addSublayer(playerLayer)
        
        addProgressObserver()
        
        addObserver()
        
        return view
    }
    
    func addProgressObserver(){
        //这里设置每秒执行一次.
        timeObserver = videoPlayer.addPeriodicTimeObserver(forInterval: CMTimeMake(Int64(1.0), Int32(1.0)), queue: .main, using: { (time) in
            //CMTimeGetSeconds函数是将CMTime转换为秒，如果CMTime无效，将返回NaN
            let currentTime = CMTimeGetSeconds(time)
            let totalTime = CMTimeGetSeconds(self.videoItem!.duration)
            self.timeLabel.text = self.formatPlayTime(seconds:  CMTimeGetSeconds(time))
            self.progress.setProgress(Float(currentTime/totalTime), animated: true)
//            print("当前已经播放\(self.formatPlayTime(seconds: CMTimeGetSeconds(time)))")

            
        })
    }
    
    //给AVPlayerItem、AVPlayer添加监控
    func addObserver(){
        //为AVPlayerItem添加status属性观察，得到资源准备好，开始播放视频
        videoItem?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        //监听AVPlayerItem的loadedTimeRanges属性来监听缓冲进度更新
        videoItem?.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd(notification:)), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: videoItem)
    }
    
    func formatPlayTime(seconds: Float64)->String{
        let Min = Int(seconds / 60)
        let Sec = Int(seconds.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", Min, Sec)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let object = object as? AVPlayerItem  else { return }
        guard let keyPath = keyPath else { return }
        if keyPath == "status"{
            if object.status == .readyToPlay{ //当资源准备好播放，那么开始播放视频
                videoPlayer.play()
                print("正在播放...，视频总长度:\(formatPlayTime(seconds: CMTimeGetSeconds(object.duration)))")
            }else if object.status == .failed || object.status == .unknown{
                print("播放出错")
            }
        }else if keyPath == "loadedTimeRanges"{
            let loadedTime = avalableDurationWithplayerItem()
            print("当前加载进度\(loadedTime)")  
        }
    }
    
    //计算当前的缓冲进度
    func avalableDurationWithplayerItem()->TimeInterval{
        guard let loadedTimeRanges = videoPlayer.currentItem?.loadedTimeRanges,let first = loadedTimeRanges.first else {fatalError()}
        //本次缓冲时间范围
        let timeRange = first.timeRangeValue
        let startSeconds = CMTimeGetSeconds(timeRange.start)//本次缓冲起始时间
        let durationSecound = CMTimeGetSeconds(timeRange.duration)//缓冲时间
        let result = startSeconds + durationSecound//缓冲总长度
        return result  
    }
    
    //播放结束，回到最开始位置，播放按钮显示带播放图标
    func playerItemDidReachEnd(notification: Notification){
        videoPlayer.seek(to: kCMTimeZero, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
        progress.progress = 0.0
//        playOrPauseButton.setImage(UIImage(named:"player_play"), for: .normal)
    }
    
    func removeObserver(){
        videoItem.removeObserver(self, forKeyPath: "status")
        videoPlayer.removeObserver(self, forKeyPath: "loadedTimeRanges")
        videoPlayer.removeTimeObserver(timeObserver)
        NotificationCenter.default.removeObserver(self, name:  Notification.Name.AVPlayerItemDidPlayToEndTime, object: videoItem)
    }
    
    deinit {
        removeObserver()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
