//
//  User.swift
//  dictionaryToModel_Swift3.0
//
//  Created by coco on 16/10/10.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var age: String?
    var sex: String?
    
    var family: Family?
    
    var hot: [Hot]?
    
    /**子类重写这个方法以声明数组中存放model*/
    override class func CustomerInArray() ->  [String: String]?{
        return ["hot":"Hot"]
    }
    
    override func setNilValueForKey(_ key: String) {
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}

class Family: NSObject {
    var father: String?
    var mother: String?
}

class Hot: NSObject {
    var name: String?
}
