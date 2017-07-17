//
//  VideoRecoderViewController.swift
//  Swift-Tools
//
//  Created by 许菠菠 on 2017/6/14.
//  Copyright © 2017年 许菠菠. All rights reserved.
//

import UIKit

class VideoRecoderViewController: UIViewController,CycleProgressViewDelegate {
    
    var photoBtn = CycleProgressView(type:.custom)
    var sureBtn = UIButton(type: .custom)
    var cancleBtn = UIButton(type: .custom)

    let screenW = UIScreen.main.bounds.size.width
    let screenH = UIScreen.main.bounds.size.height
    let buttonW = 80
    var videoRecoderView : VideoRecoderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        createUI()
                       // Do any additional setup after loading the view.
    }
    
    func createUI() {
        
        videoRecoderView = VideoRecoderView.init(frame: CGRect.init(x: 0, y:0, width: screenW, height: screenH))
        videoRecoderView.backgroundColor = .gray
        
        photoBtn.frame = CGRect(x: (Int(UIScreen.main.bounds.size.width) - buttonW)/2, y: Int(UIScreen.main.bounds.size.height) - buttonW - 50, width: buttonW, height: buttonW)
        photoBtn.layer.masksToBounds = true
        photoBtn.layer.cornerRadius = CGFloat(buttonW/2)
        photoBtn.backgroundColor = .black
        photoBtn.addLongProsess();
        photoBtn.mydelegate = self
        view.addSubview(photoBtn)
        
        
        sureBtn.setImage(UIImage(named: "done"), for: .normal)
        sureBtn.frame = CGRect(x: screenW + CGFloat(buttonW), y: photoBtn.frame.origin.y, width: CGFloat(buttonW), height: CGFloat(buttonW))
        sureBtn.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)
        view.addSubview(sureBtn)
        
        cancleBtn.setTitle("取消", for: .normal)
        cancleBtn.setTitleColor(.black, for: .normal)
        cancleBtn.frame = CGRect(x: -CGFloat(buttonW), y: photoBtn.frame.origin.y, width: CGFloat(buttonW), height: CGFloat(buttonW))
        sureBtn.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)

        view.addSubview(cancleBtn)
        
        view.insertSubview(videoRecoderView, belowSubview: photoBtn)

    }
    
    func endbuttonLongProgress() {
        updateUI()
        videoRecoderView.stopRecording()
//        let alertViewController = UIAlertController.init(title: "录制时间到", message: "", preferredStyle: .alert)
//        let sureBtn = UIAlertAction.init(title: "好", style: .default, handler: { (action) in
//            print("确定")
//        })
//        alertViewController.addAction(sureBtn)
//        self.present(alertViewController, animated: true, completion: nil)
    }
    
    func beganButtonLongProgress() {
        videoRecoderView.beginRecording()
        sureBtn.isHidden = true
        cancleBtn.isHidden = true
    }
    
    func updateUI() {
        sureBtn.isHidden = false
        cancleBtn.isHidden = false
        UIView.animate(withDuration: 1, animations: {
            self.sureBtn.frame = CGRect(x: self.screenW - CGFloat(self.buttonW) - 20, y: self.photoBtn.frame.origin.y, width: CGFloat(self.buttonW), height: CGFloat(self.buttonW))
             self.cancleBtn.frame = CGRect(x: 20, y: self.photoBtn.frame.origin.y, width: CGFloat(self.buttonW), height: CGFloat(self.buttonW))
        })
        
    }
    
    func sureBtnClick() {
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
