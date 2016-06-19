//
//  ViewController.swift
//  1.2   helloworld
//
//  Created by M-coppco on 16/6/19.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellowColor()
        let label = UILabel(frame: CGRect(x: 10, y: 170, width: 300, height: 50))
        label.text = "欢迎来到iPhone应用程序开发的世界"
        label.textColor = UIColor.blackColor()
        self.view.addSubview(label)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

