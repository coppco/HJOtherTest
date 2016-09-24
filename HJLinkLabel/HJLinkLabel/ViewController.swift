//
//  ViewController.swift
//  HJLinkLabel
//
//  Created by coco on 16/9/23.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createLabel()
        
    }

    func createLabel() {
        let label = HJLinkLabel()
        label.numberOfLines = 0
        label.frame = CGRect(x: 50, y: 200, width: 500, height: 30)
        label.attributedText = NSAttributedString(string: "我是大傻瓜, 你是大傻逼", attributes: [NSForegroundColorAttributeName: UIColor.grayColor(), NSFontAttributeName: UIFont.systemFontOfSize(17)])
        label.addLinkString("我") { (title) in
            print("我")
        }
        label.addLinkString("你是", attribute: [NSForegroundColorAttributeName: UIColor.redColor()]) { (title) in
            print("你是")
        }
        label.numberOfLines = 0
        self.view.addSubview(label
        )
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

