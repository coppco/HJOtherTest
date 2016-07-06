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

class BehaviorController: UIViewController, UICollisionBehaviorDelegate {

    var behaviorType:DynamicType!   //枚举类型
    var doSomething:behaviorClosure!  //闭包
    var animator:UIDynamicAnimator!  //存放力学行为的容器
    //行为
    lazy var gravityBehavior:UIGravityBehavior!  = {//重力行为
        let gravityBehavior = UIGravityBehavior(items: [self.bollImageV])
        //设置重力方法
        let gravityDirection:CGVector = CGVectorMake(0, 1)
        gravityBehavior.gravityDirection = gravityDirection
        return gravityBehavior
    }()
    
    lazy var collisionBehavior:UICollisionBehavior! = {  //碰撞行为
        let behavior: UICollisionBehavior = UICollisionBehavior(items: [self.bollImageV])
        let origin = self.boxV.frame.origin
        behavior.addBoundaryWithIdentifier("barrier", fromPoint: origin, toPoint: CGPointMake(origin.x + 10, origin.y))
        behavior.translatesReferenceBoundsIntoBoundary = true
        return behavior
    }()
    
    lazy var attachmentBehavior:UIAttachmentBehavior! = { //吸附行为
        let behavior = UIAttachmentBehavior(item: self.bollImageV, attachedToItem: self.boxV)
        return behavior
    }()
    
    //懒加载   球
    lazy var bollImageV:UIImageView!  =  {
        let imageView:UIImageView = UIImageView()
        imageView.image = UIImage(named: "boll")
        return imageView
    }() //懒加载属性后面  使用闭包()来初始化属性
    
    //箱子
    lazy var boxV:UIImageView! = {
        let imageView:UIImageView = UIImageView()
        imageView.image = UIImage(named: "box")
        return imageView
    }()
    
    @IBAction func back(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //解决比包内循环引用  weak 和 unowned
        /*1⃣️weak适用于可能为nil的情况
        self.doSomething = { [weak self] (type:DynamicType) in }
           2⃣️unowned适用于确定值不为空的情况下
        self.doSomething = { [unowned self] (type:DynamicType) in }
           3⃣️在闭包外面定义 weak var weakSelf = self,  闭包内部使用weakSelf
           4⃣️在闭包外面定义 unowned let weakSelf = self 闭包中使用weakSelf
        */
//        weak var weakSelf:BehaviorController! = self
//        unowned let weakSelf = self
        self.doSomething = {[unowned self] (type:DynamicType) in
            if self.animator == nil {
                self.animator = UIDynamicAnimator(referenceView: self.view)
            }
            
            switch type {
            case .GravityBehavior: //重力
                self.bollImageV.frame = CGRectMake(self.view.frame.size.width / 2 - 15, 70, 30, 30)
                self.view.addSubview(self.bollImageV)
                self.animator.addBehavior(self.gravityBehavior)
                break
            case .CollisionBehavior: //碰撞
                self.bollImageV.frame = CGRectMake(self.view.frame.size.width / 2 - 15, 70, 30, 30)
                self.view.addSubview(self.bollImageV)
                self.animator.addBehavior(self.gravityBehavior)
                self.animator.addBehavior(self.collisionBehavior)
                break
            case .AttachmentBehavior: //吸附
                self.bollImageV.frame = CGRectMake(self.view.frame.size.width / 2 - 15, 70, 30, 30)
                self.view.addSubview(self.bollImageV)
                
                self.boxV.frame = CGRectMake(self.view.frame.size.width / 2 - 50, 200, 100, 100)
                self.view.addSubview(self.boxV)
                
                self.animator.addBehavior(self.gravityBehavior)
                self.animator.addBehavior(self.collisionBehavior)
                
                let itemBehavior = UIDynamicItemBehavior(items: [self.bollImageV])
                itemBehavior.elasticity = 0.5
                self.collisionBehavior.collisionDelegate = self
                self.animator.addBehavior(itemBehavior)
                break
            case .PushBehavior:  //推
                break
            case .SnapBehavior: //甩
                break
            }
        }
        
        if (self.doSomething != nil) {
            doSomething(self.behaviorType)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    deinit {
        print("释放了")
    }

    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, atPoint p: CGPoint) {
        print("吸附了")
        //设置吸附行为
        self.animator.addBehavior(self.attachmentBehavior)
    }
    
}
