//
//  ViewController.swift
//  UILabel+HJExrtension
//
//  Created by coco on 16/9/24.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createLabel()
    }


    
    func  createLabel() {
        let object = UILabel(frame: CGRect(x: 10, y: 200, width: 300, height: 40))
        object.attributedText = NSAttributedString(string: "我是大傻瓜, 你是大傻逼", attributes: [NSForegroundColorAttributeName: UIColor.orangeColor()])
        object.addLinks(["我", "你"]) { (string) in
            
        }
        self.view.addSubview(object)
    }


}

