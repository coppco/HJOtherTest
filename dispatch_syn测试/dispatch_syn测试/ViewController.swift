//
//  ViewController.swift
//  dispatch_syn测试
//
//  Created by coco on 16/10/13.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        testDispatch_syn()
    }
    func testDispatch_syn() {
        DispatchQueue.global(qos: .default).async {
            print("1")
            DispatchQueue.main.sync {
                print("2")
            }
            print("3")
        }
        print("4")
        while true {
            
        }
        print("5")
    }

}

