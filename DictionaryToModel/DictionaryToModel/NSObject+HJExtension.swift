//
//  NSObject+HJExtension.swift
//  DictionaryToModel
//
//  Created by coco on 16/8/18.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation

//协议
@objc protocol NSObjectCanChangedProtocol {
    /**
     更改key,如把id改为ID,则返回 ["id": "ID"]
     - returns:
     */
    optional static func changeKeys() -> [String: String]
    /**
     声明数组中存放的是自定义Model
     如声明 var students: [People]  则返回 ["students": "People"]
     - returns:
     */
    optional static func customModelInArray() -> [String: String]
}

extension NSObject: NSObjectCanChangedProtocol {
    
}

extension NSObject {
    class func hj_objcetWithDictionary(dictionary: NSDictionary) -> AnyObject {
        if self.respondsToSelector(#selector(self.changeKeys())) {
            print("遵循")
        }
        
        return 2
    }
}

private struct HJExtension {
    /**当前项目的命名空间名称
     新建项目的时候使用了空格,那么空格会自动被替换成_
     */
    static let namespace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
}

