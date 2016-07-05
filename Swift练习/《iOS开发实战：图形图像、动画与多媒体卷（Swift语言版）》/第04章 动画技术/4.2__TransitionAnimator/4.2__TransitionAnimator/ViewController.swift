//
//  ViewController.swift
//  4.2__TransitionAnimator
//
//  Created by coco on 16/7/5.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit


enum HUTransitionType {
    case Transition6Style
    case TransitionGhost
    case TransitionVerticalLines
    case TransitionHorizontalLines
}
//TODO:实现两个协议UINavigationControllerDelegate,  UIViewControllerTransitioningDelegate
class ViewController: UITableViewController, UINavigationControllerDelegate,  UIViewControllerTransitioningDelegate{
    var transitonType:HUTransitionType = .Transition6Style //动画模式
    var dataArray:[String] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        self.dataArray.append("Transition 6 Style")
        self.dataArray.append("TransitionGhost")
        self.dataArray.append("TransitionVerticalLines")
        self.dataArray.append("TransitionHorizontalLines")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.dataArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = self.dataArray[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      self.performSegueWithIdentifier("push", sender: indexPath.row)
    }
    
    //TODO:segue执行前方法
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let str = segue.identifier
        if str! == "push" {
            let index = sender as! Int
            switch index {
            case 0: self.transitonType = .Transition6Style
            case 1: self.transitonType = .TransitionGhost
            case 2: self.transitonType = .TransitionHorizontalLines
            default: self.transitonType = .TransitionVerticalLines
            }
        } else if str == "present" {
            let destinationViewController = segue.destinationViewController 
            destinationViewController.transitioningDelegate = self
        }
    }
    
    
    //TODO:导航push代理
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        var animator: HUTransitionAnimator!
        
        switch self.transitonType {
        case .TransitionGhost:
            animator = HUTransitionGhostAnimator()
        case .TransitionHorizontalLines:
            animator = HUTransitionHorizontalLinesAnimator()
        case .TransitionVerticalLines:
            animator = HUTransitionVerticalLinesAnimator()
        default:
            animator = HUTransitionAnimator()
        }
        animator.presenting = (operation == UINavigationControllerOperation.Pop) ? false : true
        return animator
    }
    
    //TODO:模态代理
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HUTransitionVerticalLinesAnimator()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HUTransitionHorizontalLinesAnimator()
    }
}



