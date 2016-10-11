//
//  NSObject+HJExtension.swift
//  dictionaryToModel_Swift3.0
//
//  Created by coco on 16/10/10.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import Foundation

extension NSObject {
    /**子类重写这个方法以改变key*/
    class func changKeys() -> [String: String]? {
        return ["":""]
    }
    /**子类重写这个方法以声明数组中存放model*/
    class func CustomerInArray() ->  [String: String]?{
        return ["":""]
    }
    
    
    /**字典转模型*/
    class func dictionaryToModel(dic: [String: Any]) -> AnyObject {
        let object = self.init()
        var className: AnyClass = self.classForCoder() //当前类的类型  或者使用类名.self获取
        while "NSObject" != "\(className)" {
            var count: UInt32 = 0
            if let properties = class_copyPropertyList(className, &count) {
                for i in 0..<count {
                    let property: objc_property_t = properties[Int(i)]!  //单个属性
                    let propertyType = String(cString: property_getAttributes(property)) //属性类型
                    var propertyName: String = String(cString: property_getName(property)) //属性名称
                    if propertyType == "description" { continue }
                    
                    if var value = dic[propertyName] {
                        if let valueType = (value as AnyObject).classForCoder { //字典中存放的数据类型
                            //这里可以设置映射, 改变key值的情况
                            if self.responds(to: #selector(self.changKeys)) {
                                if let dic =  self.changKeys() {
                                    if let temp = dic[propertyName] {
                                        propertyName = temp
                                    }
                                }
                            }
                            
                            
                            if "\(valueType)".contains("NSArray") || "\(valueType)".contains("NSMutableArray") {//存放的是数组
                                
                                if self.responds(to: #selector(self.CustomerInArray)) {
                                    if var subModelClassName = self.CustomerInArray()?[propertyName] {
                                        subModelClassName = bundleName + "." + subModelClassName
                                        if let subModelClass = NSClassFromString(subModelClassName) {
                                            value = subModelClass.arrayOfDicToArrayOfModel(array: value as! [AnyObject])
                                        }
                                    }
                                }
                                
                            } else if "\(valueType)".contains("NSDictionary") || "\(valueType)".contains("NSMutableDictionary") { //字典--嵌套
                                
                                if let subModelString = getCustomerType(propertyType) {
                                    if let subModelClass: AnyClass = NSClassFromString(subModelString) {
                                        value = subModelClass.dictionaryToModel(dic: value as! [String: Any])
                                    }
                                } else {
                                    print("\(propertyName)需要一个自定义模型")
                                }
                                
                            } else {//Foundation中类型
                                if propertyType.components(separatedBy: "\"")[1] == "NSString" {
                                    if value is NSNull {
                                        object.setValue(nil, forKey: propertyName)
                                        continue
                                    } else if value is NSNumber {
                                        let number = (value as! NSNumber).doubleValue
                                        //TODO: 这里判断返回的值是不是小数, 保留原始数据
                                        if (number - floor(number)) != 0 {
                                            value = String(format: "%.12g", number) //12位以下小数显示, 以上显示指数形式
                                        } else {
                                            value = String(describing: value)
                                        }
                                    } else {
                                        value = String(describing: value)
                                    }
                                }
                            }
                            
                            object.setValue(value, forKey: propertyName)
                        } else {
                            object.setValue(nil, forKey: propertyName)
                        }
                    } else {
                        //返回的值没有数据
                        object.setValue(nil, forKey: propertyName)
                    }
                }
                free(properties)
                className = className.superclass() ?? NSObject.classForCoder()
            } else {
                return object
            }
        }
        return object
    }
    
    
    /**字典数组转模型数组*/
    class func arrayOfDicToArrayOfModel(array: [AnyObject]) -> [Any] {
        if array.count == 0 {
            return []
        }
        var result = [Any]()
        
        for item in array {
          let type = "\(item.classForCoder)"
            
            if type.contains("NSDictionary") || type.contains("NSMutableDictionary") {
                result.append(dictionaryToModel(dic: item as! [String : Any]))
            }else if type.contains("NSArray") || type.contains("NSMutableArray"){
                result.append(arrayOfDicToArrayOfModel(array: item as! [AnyObject]))
            }else{
                result.append(item)
            }
        }
        return result
    }
    
    var keyValues: [String: Any] {
        get {
            var result = [String: Any]()
            var classType:AnyClass = self.classForCoder
            
            while("NSObject" !=  "\(classType)" ) {
                var count:UInt32 = 0
                if let properties = class_copyPropertyList(classType, &count) {
                    
                    for i in 0..<count {
                        let property = properties[Int(i)]
                        let propertyName = String(cString: property_getName(property))         //模型中属性名称
                        let propertyType = String(cString: property_getAttributes(property))  //模型中属性类型
                        
                        if "description" == propertyName{ continue }   //描述，不是属性
                        let tempValue = self.value(forKey: propertyName)
                        
                        if let _ = getCustomerType(propertyType) { //自定义类
                            if tempValue == nil {
                                result[propertyName] = [:]
                                continue
                            } else {
                                result[propertyName] = (tempValue as AnyObject).keyValues
                            }
                        } else if propertyType.contains("NSArray") || propertyType.contains("NSMutableArray") {
                            //数组
                            if tempValue == nil {
                                result[propertyName] = []
                                continue
                            } else {
                                //TODO:
                                let temp = tempValue as! NSArray
                                result[propertyName] = (temp as Array).keyValuesArray

                            }
                        } else {
                            // 基本数据类型
                            if tempValue == nil {
                                result[propertyName] = ""
                            } else {
                                result[propertyName] = tempValue
                            }
                        }
                        
                    }
                    free(properties)
                    classType = classType.superclass()!
                } else {
                    return result
                }
            }
            return result
        }
    }
    
}



extension Dictionary {
    var keyValues: [String: Any] {
        get {
            var result = [String: Any]()
            
            for (key, value) in self {
                if let valueType = (value as AnyObject).classForCoder {
                    if !isClassFromFoundation(valueType) { //自定义类
                        result[String(describing: key)] = (value as AnyObject).keyValues
                    } else if "\(valueType)".contains("NSArray") || "\(valueType)".contains("NSMutableArray") {//数组
                        //TODO:
                        let temp = value as! NSArray
                        result[String(describing: key)] = (temp as Array).keyValuesArray
                    } else {
                        //基本类型
                        result[String(describing: key)] = value
                    }
                } else {
                    result[String(describing: key)] = nil
                    continue
                }
            }
            return result
        }
    }
    
}


extension Array {
    var keyValuesArray: [Any] {
        get {
            var result = [Any]()
            for item in self {
                if let valueType = (item as AnyObject).classForCoder {
                    if !isClassFromFoundation(valueType) { //自定义类
                        result.append((item as AnyObject).keyValues)
                    } else if "\(valueType)".contains("NSArray") || "\(valueType)".contains("NSMutableArray") {//数组
                        result.append((item as! Array).keyValuesArray)
                    } else {
                        //基本类型
                        result.append(item)
                    }
                } else {
                    continue
                }
            }
            return result
        }
    }
}



/**
 获取自定义类的类名, 自定义类
 
 - parameter code: String.fromCString(property_getAttributes(property))!获取到的类名,如果是自定义类型,会包含其他字符等, 如T@"_TtC15工程名4User",N,&,Vuser  或者  T@"NSString",N,C,Vname======
 - returns:
 */
private  func getCustomerType(_ code: String) -> String? {
    if !code.contains(bundleName) {
        return nil
    }
    var temp: String = ""
    let array = code.components(separatedBy: "\"")
    if array.count >= 1 {
        temp = array[1]
    }
    if let range = temp.range(of: bundleName) {
        temp = temp.substring(from: range.upperBound)
        var number: String = ""  //类名前面的数字
        for c: Character in temp.characters {
            if c >= "0" && c <= "9" {
                number += String(c)
            }
        }
        if let range = temp.range(of: number) {
            temp = temp.substring(from: range.upperBound)
        }
        return bundleName + "." + temp
    }
    return nil
}
/**工程名称*/
private let bundleName = (Bundle.main.infoDictionary!["CFBundleExecutable"] as! String).replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: ".", with: "_")
    

private let set = NSSet(array: [
    NSURL.classForCoder(),
//    Date.ReferenceType().classForCoder,
    NSDate.classForCoder(),
    NSValue.classForCoder(),
//    Data.ReferenceType().classForCoder,
    NSData.classForCoder(),
    NSError.classForCoder(),
    NSArray.classForCoder(),
    NSDictionary.classForCoder(),
    NSString.classForCoder(),
    NSAttributedString.classForCoder()
    ])

private func isClassFromFoundation(_ c:AnyClass)->Bool {
    var  result = false
    if c == NSObject.classForCoder(){
        result = true
    }else{
        set.enumerateObjects({ (foundation,  stop) -> Void in
            if  c.isSubclass(of: foundation as! AnyClass) {
                result = true
                stop.initialize(to: true)
            }
        })
    }
    return result
}

