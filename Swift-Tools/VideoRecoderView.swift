//
//  VideoRecoderView.swift
//  Swift-Tools
//
//  Created by 许菠菠 on 2017/7/5.
//  Copyright © 2017年 许菠菠. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class VideoRecoderView: UIView ,AVCaptureFileOutputRecordingDelegate{
     //视频捕获会话。它是input和output的桥梁。它协调着intput到output的数据传输
    let captureSession = AVCaptureSession()
    //视频输入设备
    let videoDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    //音频输入设备
    let audioDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio)
    //将捕获到的视频输出到文件
    let fileOutput = AVCaptureMovieFileOutput()
    //表示是否在录制
    var isRecording = false
    //视频截图
    var frameImg : UIImage!
    override init(frame: CGRect) {
        super.init(frame: frame)
        //添加音频，视频输入设备
        let videoInput = try! AVCaptureDeviceInput(device: self.videoDevice)
        self.captureSession.addInput(videoInput)
        let audioInput = try! AVCaptureDeviceInput(device: self.audioDevice)
        self.captureSession.addInput(audioInput)
        //添加视频捕获输出
        self.captureSession.addOutput(self.fileOutput)
        
        //使用AVCaptureVideoPreviewLayer可以将摄像头的拍摄的实时画面显示在View上
        let videoPlayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        videoPlayer?.frame = self.bounds
        videoPlayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.layer.addSublayer(videoPlayer!)
        
        //开始session会话
        self.captureSession.startRunning()
        
    }
    
    func beginRecording() {
        if !self.isRecording {
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentDirectory = paths[0] as String
            let filePath = "\(documentDirectory)/temp.mp4"
            let fileUrl = NSURL(fileURLWithPath: filePath)
            fileOutput.startRecording(toOutputFileURL: fileUrl as URL!, recordingDelegate: self)
            
            self.isRecording = true
        }
    }
    
    func stopRecording() {
        if self.isRecording {
            fileOutput.stopRecording()
            self.isRecording = false
        }
        
    }
    
    //录像开始的代理方法 
    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
        print("开始录制")
    }
    
    //录像结束的代理方法
    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
        print("录制完成")
        let avAsset = AVAsset(url: outputFileURL)
        //生成视频截图
        let generator = AVAssetImageGenerator(asset: avAsset)
        generator.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(0.0,600)
        var actualTime:CMTime = CMTimeMake(0,0)
        let imageRef:CGImage = try! generator.copyCGImage(at: time, actualTime: &actualTime)
        frameImg = UIImage(cgImage: imageRef)
        
        PHPhotoLibrary.shared().performChanges({ 
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: outputFileURL)
        }) { (isSuccess, error) in
            if isSuccess {
                print("保存成功")
            }else {
                print("保存失败")
            }
        }
    }
    
    func getVideoImage() -> UIImage {
        return frameImg
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
