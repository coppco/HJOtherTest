//
//  ViewController.swift
//  4.3__DynamicBehaviorSample
//
//  Created by coco on 16/7/5.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

//枚举和String关联了, 使用成员.rawValue 获取值
enum DynamicType:String {
    case GravityBehavior = "重力行为" //重力行为
    case CollisionBehavior = "碰撞行为" //碰撞行为
    case AttachmentBehavior = "吸附行为" //吸附行为
    case PushBehavior = "推行为"  //推行为
    case SnapBehavior = "甩行为" //甩行为
}


class ViewController: UITableViewController {

    var behaviorType:DynamicType = .GravityBehavior
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
        case 0: self.behaviorType = .GravityBehavior
        case 1: self.behaviorType = .CollisionBehavior
        case 2: self.behaviorType = .AttachmentBehavior
        case 3: self.behaviorType = .PushBehavior
        default: self.behaviorType = .SnapBehavior
        }
        
        self.performSegueWithIdentifier("Dynamic", sender: self.behaviorType.rawValue)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationViewController:BehaviorController = segue.destinationViewController as! BehaviorController
        destinationViewController.behaviorType = self.behaviorType
        destinationViewController.title = self.behaviorType.rawValue
    }
    
    
}

