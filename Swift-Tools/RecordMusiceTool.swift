//
//  RecordMusiceTool.swift
//  Swift-Tools
//
//  Created by 许菠菠 on 2017/6/13.
//  Copyright © 2017年 许菠菠. All rights reserved.
//

import UIKit
import AVFoundation

class RecordMusiceTool: NSObject {
    var audioRecoder : AVAudioRecorder!
    var audionPlayer : AVAudioPlayer!
    
    var audioSession : AVAudioSession!
    let recordSetting = [AVSampleRateKey : NSNumber(value:Float(44100.0)),//声音采样率
        AVFormatIDKey : NSNumber(value:Int32(kAudioFormatMPEG4AAC)),//编码格式
        AVNumberOfChannelsKey : NSNumber(value:1),//采集音轨
        AVEncoderAudioQualityKey : NSNumber(value:Int32(AVAudioQuality.medium.rawValue))]//音频质量
    var viewController1 : UIAlertController!
    var isAllowed = false
    
    
    override init(){
        super.init()
        //获取录音回话的单利
        audioSession = AVAudioSession.sharedInstance()
        //定义录音的编码参数
        
    }
    
    func initRecoder(viewController:UIViewController) {
        audioSession.requestRecordPermission { (allowed) in
            if !allowed {
                let alertViewController = UIAlertController.init(title: "无法访问您的麦克风", message: "请到设置 -> 隐私 -> 麦克风 ，打开访问权限", preferredStyle: .alert)
                let cancleBtn = UIAlertAction(title: "取消", style: .cancel)
                let sureBtn = UIAlertAction.init(title: "好", style: .default, handler: { (action) in
                    print("确定")
                })
                alertViewController.addAction(cancleBtn)
                alertViewController.addAction(sureBtn)
                viewController.present(alertViewController, animated: true, completion: nil)
                self.isAllowed = false
            }else{
                self.isAllowed = true
            }
            
        }
        
        
    }
    
    func createMusicURL() -> URL {
        //定义并构建一个url来保存音频，音频文件名为ddMMyyyyHHmmss.caf，根据时间来设置存储文件名  
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMyyyyHHmmss"
        let recoderingName = formatter.string(from: currentDateTime) + ".m4a"
        let fileMange = FileManager.default
        let urls = fileMange.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls[0] as NSURL
        let soundUrl = documentDirectory.appendingPathComponent(recoderingName)
        return soundUrl!
    }
    
    func startRecord(finish:@escaping(_ audioRecoder:AVAudioRecorder,_ audioSession:AVAudioSession)->()) {
        if self.isAllowed {
            do {
                
                try self.audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
                //初始化实例
                try self.audioRecoder = AVAudioRecorder(url: self.createMusicURL(), settings: self.recordSetting)
                
            }catch let error as Error {
                print(error)
            }
            finish(self.audioRecoder,self.audioSession)
        }
        
    
       
    }
    
    func stopRecord(finish:@escaping(_ audioRecoder:AVAudioRecorder)->()) {
        if audioRecoder.isRecording {
            finish(self.audioRecoder)
        }
    }
    
    func startPlaying(finish:@escaping(_ audioPlayer:AVAudioPlayer)->()) {
        if !audioRecoder.isRecording {
            do {
                let url : URL = audioRecoder.url
                
                try audionPlayer = AVAudioPlayer.init(contentsOf: url)
                
            } catch let error as Error {
                print(error)
            }
            finish(self.audionPlayer)
        }
    }
    
    func pasuePlaying(finish:@escaping(_ audioPlayer:AVAudioPlayer)->()) {
        
        if audionPlayer.isPlaying && !audioRecoder.isRecording {
            finish(self.audionPlayer)
        }
        
    }
    
}
