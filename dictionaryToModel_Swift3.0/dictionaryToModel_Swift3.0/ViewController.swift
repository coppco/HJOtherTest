//
//  ViewController.swift
//  dictionaryToModel_Swift3.0
//
//  Created by coco on 16/10/10.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let dic = ["name": "xhj", "age": "20", "sex": "男", "family": ["mother": "abc", "father": "def"], "hot": [["name": "你好"], ["name": "我也好"]]] as [String : Any]
        let dic = ["name": "xhj", "age": "20", "sex": "男", "family": ["mother": "abc", "father": "def"]] as [String : Any]
        let model = User.dictionaryToModel(dic: dic) as! User
        
        print(model.keyValues)

        let aaa = ["1": "a", "2": "b", "3": "c", "4": ["d", "e", "f"]] as [String : Any]
        print(aaa.keyValues)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

