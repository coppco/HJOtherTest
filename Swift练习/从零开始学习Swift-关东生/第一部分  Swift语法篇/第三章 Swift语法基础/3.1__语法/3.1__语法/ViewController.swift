//
//  ViewController.swift
//  3.1__语法
//
//  Created by M-coppco on 16/6/23.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import UIKit

//声明了一个类
class Person {
    var name : String
    var age : Int
    init(name : String, age : Int) {
        self.name = name
        self.age = age
    }
}

class ViewController: UIViewController {

    

    override func viewDidLoad() {
        super.viewDidLoad()
       let person = Person(name: "王五", age: 20)
        person.name = "李四";person.age = 90
        //下面这句要修改,需要设置为var
//        person = Person(name: "张珊", age: 19)
        /**
        var str = "hello"
        print(str)
        str = "dsfdsd"
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

