//
//  CycleProgressView.swift
//  Swift-Tools
//
//  Created by 许菠菠 on 2017/6/14.
//  Copyright © 2017年 许菠菠. All rights reserved.
//

import UIKit

protocol CycleProgressViewDelegate : NSObjectProtocol {
    func endbuttonLongProgress()
    func beganButtonLongProgress()
}

class CycleProgressView: UIButton {

    var progress : CGFloat = 0
    var gointTime : CGFloat = 0.00;
    
    var progressLayer = CAShapeLayer()//创建一个track shape layer
    var timer : Timer!
    weak var mydelegate : CycleProgressViewDelegate!
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        let center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)  //设置圆心位置
        let radius = self.bounds.size.width/2;  //设置半径
        let startA = -M_PI_2;  //圆起点位置
        let endA = CGFloat(-M_PI_2) + CGFloat(M_PI * 2) * self.gointTime //圆终点位置
        
        progressLayer.frame = self.bounds
        progressLayer.fillColor = UIColor.clear.cgColor  //填充色为无色
        progressLayer.strokeColor = UIColor.red.cgColor //指定path的渲染颜色,这里可以设置任意不透明颜色
        progressLayer.opacity = 1; //背景颜色的透明度
        progressLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
        progressLayer.lineWidth = 10;//线的宽度
        let path = UIBezierPath.init(arcCenter: center, radius: CGFloat(radius), startAngle: CGFloat(startA), endAngle: CGFloat(endA), clockwise: true)
        progressLayer.path = path.cgPath
        self.layer.addSublayer(progressLayer)
    }
    
    func drawProgress(progress:CGFloat) {
        self.progress = progress
        if progress == 0 {
            gointTime = 0.00
            setNeedsDisplay()
            mydelegate.endbuttonLongProgress()
            return
        }
        delay()
    }
    
    func delay() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerGoing(going:)), userInfo: nil, repeats: true)
    }
    
    func timerGoing(going:Timer) {
        if gointTime > self.progress + 0.002 {
            timer.invalidate()
            timer = nil
            mydelegate.endbuttonLongProgress()
            return;
        }
        self.setNeedsDisplay()
        gointTime += 0.002
    }
    
    func addLongProsess()  {
        self.isUserInteractionEnabled = true
        let prosessClick = UILongPressGestureRecognizer(target: self, action: #selector(buttonTouchLongTime(longProsessTime:)))
        prosessClick.minimumPressDuration = 1
        prosessClick.allowableMovement = 5
        prosessClick.numberOfTouchesRequired = 1
        self.addGestureRecognizer(prosessClick)
        
    }
    
    
    
    func buttonTouchLongTime(longProsessTime:UILongPressGestureRecognizer) {
        if longProsessTime.state == .began {
            mydelegate.beganButtonLongProgress()
            drawProgress(progress: 1)
        }else if longProsessTime.state == .ended {
            drawProgress(progress: 0)
        }
    }

}
