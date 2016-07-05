//
//  ViewController.swift
//  4.1__AnimationBlock
//
//  Created by coco on 16/7/5.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //球
    @IBOutlet weak var bollImageV: UIImageView!
    @IBOutlet weak var topHeight: NSLayoutConstraint!  //距离上面高度
    @IBOutlet weak var height: NSLayoutConstraint!  //球大小
    var isAnimation:Bool = false
    
    //TODO:上下按钮点击方法
    @IBAction func upAndDown(sender: UIButton) {
        if true == self.isAnimation {
            return
        }
        self.isAnimation = true
        sender.selected = !sender.selected
        if sender.selected {
            self.topHeight.constant = 400
            self.height.constant = 100
        } else {
            self.topHeight.constant = 30
            self.height.constant = 30
        }
        //在UIView动画里面使用layoutIfNeeded()方法,即可出现动画
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.layoutIfNeeded()  //重新布局
            }) { (Bool) -> Void in
            self.isAnimation = false
        }
    
    }
    
    //TODO: 动画
    @IBAction func animation() {
        self.view.backgroundColor = randomColor()
        //Swift里面, 诸如:UIViewAnimationOptions 参数可以多选的情况,使用数组[,],[UIViewAnimationOptions.TransitionCurlUp, UIViewAnimationOptions.CurveEaseIn]
        UIView.transitionWithView(self.view, duration: 0.5, options: [UIViewAnimationOptions.TransitionCurlUp, UIViewAnimationOptions.CurveEaseIn], animations: { () -> Void in
            
            }) { (Bool) -> Void in

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func randomColor() ->UIColor {
        return UIColor(red: CGFloat(random() % 256) / 256.0, green: CGFloat(random() % 256) / 256.0, blue: CGFloat(random() % 256) / 256.0, alpha: 1)
    }

}

