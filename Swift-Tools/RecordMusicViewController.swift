//
//  RecordMusicViewController.swift
//  Swift-Tools
//
//  Created by 许菠菠 on 2017/6/13.
//  Copyright © 2017年 许菠菠. All rights reserved.
//

import UIKit
import AVFoundation

class RecordMusicViewController: BaseViewController ,AVAudioRecorderDelegate,AVAudioPlayerDelegate{

    var buttonArray = [UIButton]()
    var recordeMusice = RecordMusiceTool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "录制音频"
        
        recordeMusice.initRecoder(viewController: self)
        // Do any additional setup after loading the view.
        createUI();
    }
    func createUI() {
        let buttonTexts = ["startRecord","stopRecord","startPlaying","pausePlaying"]
        let space = 100
        for i in [0,1,2,3] {
            let button = UIButton(type:.custom)
            button.frame = CGRect(x: Int(view.center.x) - 75, y: space + space * i,width: 150, height: 20)
            button.setTitle(buttonTexts[i], for: .normal)
            button.setTitleColor(.blue, for: .normal)
            button.setTitleColor(.red, for: .selected)
            buttonArray.append(button)
            button.addTarget(self, action: #selector(self.buttonAction(button:)), for:UIControlEvents.touchUpInside)
            view.addSubview(button)
        }
    }
    func buttonAction(button:UIButton) {
        for btn in buttonArray {
            if btn == button {
                btn.isSelected = true
            }else{
                btn.isSelected = false
            }
        }
        
        if button.titleLabel?.text == "startRecord" {
            recordeMusice.startRecord {
                (audioRecoder,audioSession) in
                //判断是否正在录音
                audioRecoder.delegate = self
                audioRecoder.prepareToRecord()
                if !audioRecoder.isRecording {
                    do {
                        try audioSession.setActive(true)
                        audioRecoder.record()
                    } catch let error as NSError {
                        print(error)
                    }
                }

            }
        }else if button.titleLabel?.text == "stopRecord" {
            recordeMusice.stopRecord{(audioRecoder) in
                audioRecoder.stop()
            }
        }else if button.titleLabel?.text == "startPlaying" {
            recordeMusice.startPlaying(finish: { (avaudioPlayer) in
                avaudioPlayer.delegate = self
                avaudioPlayer.play()
            })
        }else if button.titleLabel?.text == "pausePlaying" {
            recordeMusice.pasuePlaying(finish: { (avaudioPlayer) in
                avaudioPlayer.pause()
            })
        }else{
            return
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            let alertViewController = UIAlertController.init(title: "录制完成", message: "", preferredStyle: .alert)
            let sureBtn = UIAlertAction.init(title: "好", style: .default, handler: { (action) in
                print("确定")
            })
            alertViewController.addAction(sureBtn)
            self.present(alertViewController, animated: true, completion: nil)
        }
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            print("播放完成");
        }
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
