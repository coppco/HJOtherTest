//
//  ViewController.swift
//  Swift3
//
//  Created by coco on 16/10/11.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit
import HandyJSON
class ViewController: UIViewController {

    
    
    /// 系统的
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        testDicToModel()
//        textStringSize()
//        device()
        testTextField()
        
//        UITextFieldDelegate
//        UITextView
        
//        print("123.89".numberValue()?.stringValue)
//        print("123.89".doubleValue())
//        print("123.89".floatValue())
//        print("0xFF".numberValue())
//        print(NSNumber.st)
//        print("123.89".intValue())
//        print("9a.90".doubleValue())
//        print(Double("9a.90"))
//        print(Date().year)
//        print(Date().nanosecond)
//        print(Date().hour)
//        print(Date().minute)
        
        let string = "2016-10-10 10:56:32"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: string)

//        print(Date.dateFromString(string: string, formatter: SQLDataFormatter))
        
//        print(date?.stringWithSQLDataFormatter())
        
        let dic = ["a", "b", "c", "d", 1, "2", 3] as [Any]
        let data = try? JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.init(rawValue: 0))
        let str = String(data: data!, encoding: String.Encoding.utf8)
//        print(str)
        
        let bu = UIButton(type: UIButtonType.custom)
        bu.frame = CGRect(x: 50, y: 100, width: 100, height: 50)
        bu.setTitle("变换颜色", for: UIControlState.normal)
        bu.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.view.addSubview(bu)
        bu.addTarget(self, action: #selector(changeColor), for: UIControlEvents.touchUpInside)
        
        
//        print(self.view.width)
        self.view.center = CGPoint.zero
//        self.view.setlay
        
        
//        print(documentsURL())
        if UIApplication.shared.canOpenURL(documentsURL()) {
            UIApplication.shared.openURL(documentsURL())
        } else {
            print("false")
        }
        let label = UILabel(frame: CGRect(x: 50, y: 200, width: 200, height: 30))
        label.text = Date().thirdteenTimeSamp()
        self.view.addSubview(label)
        
//        HHLog()
//        print(documentsPath())
//        print(documentsURL())
//        print(documentsPathAppendFileName(fileName: "abc"))
//        print(fileInSubDirectoryOfDocumentsDirectory(subPath: "abc", fileName: "1.txt"))
    }
    
    @objc func changeColor() {
//        self.view.backgroundColor = UIColor.colorWithHexString(hex: " #CD853F  ")
        self.view.backgroundColor = UIColor.randomColor()
//        self.view.backgroundColor = UIColor.colorWithRGBAValue(rgbaValue: 0xcd8)
    }
    
    
    func testTextField() {
        let textField = UITextField(frame: CGRect(x: 40, y: 250, width: 200, height: 30))
//        textField.regex = "^([1-9]\\d{0,7}|0)?((\\.|,)[0-9]{0,2})?$"
//        textField.regex = "^([1-9]\\d{0,7}|0)?1((\\.|,)[0-9]{0,2})?$"
        textField.borderStyle = .roundedRect
        textField.delegate = self
        self.view.addSubview(textField)
        
//        let text = "123 abc1 23dd d3454 3d1 123"
//        text.enumerateMatches(pattern: "[0-9]{2,}", options: NSRegularExpression.Options.caseInsensitive) { (result, flags, pointer) in
//            if let temp = result?.range {
//                let range = text.index(text.startIndex, offsetBy: temp.location) ..< text.index(text.startIndex, offsetBy: temp.location + temp.length)
//                print(text.substring(with: range))
//            }
//        }
    }
    

    /// 设备信息
    func device() {
        switch Device() {
        case .iPhone4, .simulator(.iPhone4):
            print("运行在320*480")
        case .iPhone4s, .simulator(.iPhone4s):
            print("运行在640*960")
        case .iPhone5, .iPhone5c, .iPhone5s, .iPhoneSE, .simulator(.iPhoneSE), .simulator(.iPhone5), .simulator(.iPhone5s), .simulator(.iPhone5c):
            print("运行在640*1136")
        case .iPhone6, .iPhone6s, .iPhone7, .simulator(.iPhone6s), .simulator(.iPhone6), .simulator(.iPhone7):
            print("运行在750*1334")
        case .iPhone6Plus, .iPhone7Plus, .iPhone6sPlus, .simulator(.iPhone6sPlus), .simulator(.iPhone7Plus), .simulator(.iPhone6Plus):
            print("运行在1242*2208")
            print(UIScreen.main.bounds)
        default:
            print("other")
        }
    }
    
    /// 字典转模型
    func testDicToModel() {
        let jsonString = "{\"name\":\"cat\",\"sex\":\"12345\",\"age\":180}"
        
        if let animal = JSONDeserializer<Person>.deserializeFrom(json: jsonString) {
            print(animal.name)
        } else {
            print("abc")
        }
        
        if let anima2 = JSONDeserializer<Person>.deserializeFrom(dict: ["name": "dog", "sex": "232", "age": 20]) {
            print(anima2.name)
        }
    }
    
    
    /// 字符串size
    func textStringSize() {
        let string = "剩余电量\(Device().batteryLevel)%"
        
        let label = UILabel(frame: CGRect(x: 20, y: 50, width: string.width(font: 15), height: 30))
        label.font = UIFont.systemFont(ofSize: 15)
        print(label.frame.size.width, label.frame.size.height)
        label.text = string
        label.backgroundColor = UIColor.red
        self.view.addSubview(label)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        "^([1-9]\\d{0,7}|0)?((\\.|,)[0-9]{0,2})?$"    //匹配两位有效数字
        "^[\\s\\S]{10}$"
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//        isascii(<#T##_c: Int32##Int32#>)
        
        print(newString)
        return (newString.matchesRegex(pattern: "^([1-9]\\d{0,7}|0)?((\\.|,)[0-9]{0,2})?$", options: NSRegularExpression.Options.caseInsensitive))
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        print((textField.text! as NSString).doubleValue)
    }
}

