//
//  BehaviorController.swift
//  4.3__DynamicBehaviorSample
//
//  Created by coco on 16/7/5.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

//重命名,类似于OC中的typedef
typealias behaviorClosure = (DynamicType) ->Void

class BehaviorController: UIViewController {

    var behaviorType:DynamicType!   //枚举类型
    var doSomething:behaviorClosure!  //闭包
    var animator:UIDynamicAnimator!  //存放力学行为的容器
    //行为
    var gravityBehavior:UIGravityBehavior!  //重力行为
    
    //懒加载   球
    lazy var bollImageV:UIImageView!  =  {
        let imageView:UIImageView = UIImageView()
        imageView.image = UIImage(named: "boll")
        return imageView
    }() //懒加载属性后面  使用闭包()来初始化属性
    
    @IBAction func back(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.doSomething = { (type:DynamicType) in
            if self.animator == nil {
                self.animator = UIDynamicAnimator(referenceView: self.view)
            }
            
            switch type {
            case .GravityBehavior: //重力
                if self.gravityBehavior == nil {
                    self.bollImageV.frame = CGRectMake(self.view.frame.size.width / 2 - 15, 70, 30, 30)
                    self.view.addSubview(self.bollImageV)
                    self.gravityBehavior = UIGravityBehavior(items: [self.bollImageV])
                    //设置重力方法
                    let gravityDirection:CGVector = CGVectorMake(0, 0.1)
                    self.gravityBehavior.gravityDirection = gravityDirection
                }
                self.animator.addBehavior(self.gravityBehavior)
                break
            case .CollisionBehavior: //碰撞
                break
            case .AttachmentBehavior: //吸附
                break
            case .PushBehavior:  //推
                break
            case .SnapBehavior: //甩
                break
            }
        }
        doSomething(self.behaviorType)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
