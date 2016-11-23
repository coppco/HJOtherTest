//
//  NSNumber+HJExtension.swift
//  Swift3
//
//  Created by coco on 16/10/13.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation

extension NSNumber {
    
    /// 字符串转NSNumber
    ///
    /// - parameter string: 字符串
    /// - returns: 返回一个可选NSNumber
    class func numberFromString(string: String) -> NSNumber? {
        let temp = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)//去掉首位空字符串
        if temp.characters.count == 0 {
            return nil
        }
        
        if temp == "true" || temp == "yes" {
            return NSNumber(value: true)
        }
        if temp == "no" || temp == "false" {
            return NSNumber(value: false)
        }
        
        if temp == "nil" || temp == "null" || temp == "<null>" {
            return nil
        }
        
        //hex number
        if temp.hasPrefix("0x") || temp.hasPrefix("0X") || temp.hasPrefix("-0x") || temp.hasPrefix("-0X") {
            let scan = Scanner(string: temp)
            var result: UInt64 = 0
            //Scanner 主要是用于扫描字符串
            if scan.scanHexInt64(&result) {
                var sign: Int = 0
                if temp.hasPrefix("0x") || temp.hasPrefix("0X") {
                    sign = 1
                }
                if temp.hasPrefix("-0x") || temp.hasPrefix("-0X") {
                    sign = -1
                }
                return NSNumber(value: result * UInt64(sign))
            }
            return nil
        }
        
        // normal number
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: temp)
    }
}
