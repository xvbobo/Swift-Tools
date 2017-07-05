//
//  FirstViewController.swift
//  Swift-Tools
//
//  Created by 许菠菠 on 2017/6/5.
//  Copyright © 2017年 许菠菠. All rights reserved.
//

import UIKit

class FirstViewController: BaseViewController {

    let diceView = UIView()
    var angle = CGPoint.init(x: 0, y: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        addDice()
        title = "3D旋转"
        view.backgroundColor = UIColor.white

        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewTransform))
        diceView.addGestureRecognizer(panGesture)
        // Do any additional setup after loading the view.
    }
    
    func addDice() {
        //1的对面是6，2的对面是4，3的对面是5
        let viewFrame = UIScreen.main.bounds
        var diceTransform = CATransform3DIdentity
        diceView.frame = CGRect.init(x: 0, y: viewFrame.maxY/2 - 50, width: viewFrame.width, height: 100)
        
        //1
        let dice1 = UIImageView.init(image: UIImage.init(named: "dice1"))
        dice1.frame = CGRect.init(x: viewFrame.maxX/2 - 50, y: 0, width: 100, height: 100)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, 50)
        dice1.layer.transform = diceTransform
        diceView.addSubview(dice1)
        
        //6
        let dice6 = UIImageView.init(image: UIImage.init(named: "dice6"))
        dice6.frame = CGRect.init(x: viewFrame.maxX/2 - 50, y: 0, width: 100, height: 100)
        diceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 0, -50)
        dice6.layer.transform = diceTransform
        diceView.addSubview(dice6)

        //2
        let dice2 = UIImageView.init(image: UIImage.init(named: "dice2"))
        dice2.frame = CGRect.init(x: viewFrame.maxX/2 - 50, y: 0, width: 100, height: 100)
        diceTransform = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi/2), 0, 1, 0)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, 50)
        dice2.layer.transform = diceTransform
        diceView.addSubview(dice2)
        
        //4
        let dice4 = UIImageView.init(image: UIImage.init(named: "dice4"))
        dice4.frame = CGRect.init(x: viewFrame.maxX/2 - 50, y: 0, width: 100, height: 100)
        diceTransform = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi/2), 0, 1, 0)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, -50)
        dice4.layer.transform = diceTransform
        diceView.addSubview(dice4)

        //3
        let dice3 = UIImageView.init(image: UIImage.init(named: "dice3"))
        dice3.frame = CGRect.init(x: viewFrame.maxX/2 - 50, y: 0, width: 100, height: 100)
        diceTransform = CATransform3DRotate(CATransform3DIdentity, (-CGFloat.pi/2), 1, 0, 0)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, 50)
        dice3.layer.transform = diceTransform
        diceView.addSubview(dice3)
        
        
        //5
        let dice5 = UIImageView.init(image: UIImage.init(named: "dice5"))
        dice5.frame = CGRect.init(x: viewFrame.maxX/2 - 50, y: 0, width: 100, height: 100)
        diceTransform = CATransform3DRotate(CATransform3DIdentity, (-CGFloat.pi/2), 1, 0, 0)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, -50)
        dice5.layer.transform = diceTransform
        diceView.addSubview(dice5)
        
       
        
        self.view.addSubview(diceView)
    }
    
    func viewTransform(sender:UIPanGestureRecognizer) {
        let point = sender.translation(in: diceView)
        let angleX = angle.x + point.x/30
        let angleY = angle.y - point.y/30
        
        var transform = CATransform3DIdentity
        transform.m34 = -1/500
        transform = CATransform3DRotate(transform, angleX, 0, 1, 0)
        transform = CATransform3DRotate(transform, angleY, 1, 0, 0)
        diceView.layer.sublayerTransform = transform
        if sender.state == .ended {
            angle.x = angleX
            angle.y = angleY
        }
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
