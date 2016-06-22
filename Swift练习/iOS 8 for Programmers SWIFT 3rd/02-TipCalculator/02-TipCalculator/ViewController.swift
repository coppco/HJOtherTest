//
//  ViewController.swift
//  02-TipCalculator
//
//  Created by coco on 16/4/26.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
/*输入的账单金额*/
    @IBOutlet weak var billAmount: UILabel!
/*自定义小费*/
    @IBOutlet weak var customTipPercent: UILabel!
    @IBOutlet weak var customTipPercent2: UILabel!
    
/*滑动条*/
    @IBOutlet weak var customTipPercentageSlider: UISlider!
/*15%小费*/
    @IBOutlet weak var tip15: UILabel!
/*18%小费*/
    @IBOutlet weak var tip18: UILabel!
/*15%小费总金额*/
    @IBOutlet weak var total15: UILabel!
/*18%小费总金额*/
    @IBOutlet weak var total18: UILabel!
/*输入框*/
    @IBOutlet weak var textField: UITextField!
    
/*常量,这里没有指定类型, swift有类型推导*/
    let decima100 = NSDecimalNumber(string: "100.0")
    let decimal15Percent = NSDecimalNumber(string: "0.15")
    
/*变量*/
    
    var inputTotal : NSDecimalNumber!
    var myPercent : NSDecimalNumber!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
        //小费比例
        myPercent = NSDecimalNumber(integer: Int(customTipPercentageSlider.value)) / decima100
        inputTotal = NSDecimalNumber(float: 0.0)
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action:#selector(ViewController.tap)))
    }
    func tap(tap:UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

/*文本框结束输入*/
    @IBAction func calculateTip(sender: UITextField) {
        
        if ((sender.text?.isEmpty) != true) {
            inputTotal = NSDecimalNumber(string: sender.text)
        } else {
            billAmount.text = nil
            tip15.text = nil
            total15.text = nil
            
            tip18.text = nil
            total18.text = nil
            return
        }
        self.updateLabel();
    }
    
/*滑块滑动*/
    @IBAction func tipChange(sender: UISlider) {
        //小费比例
        myPercent = NSDecimalNumber(integer: Int(customTipPercentageSlider.value)) / decima100;
        var label = String(myPercent * decima100)
        label += "%"
        customTipPercent.text = label
        customTipPercent2.text = label
        
        self.updateLabel()
    }
    
    //更新文本内容
    func updateLabel() {
        billAmount.text = formatFromDecimal(inputTotal)
        tip15.text = formatFromDecimal(inputTotal * decimal15Percent)
        total15.text = formatFromDecimal(inputTotal + inputTotal * decimal15Percent)
        
        tip18.text = formatFromDecimal(inputTotal * myPercent)
        total18.text = formatFromDecimal(inputTotal + inputTotal * myPercent)
    }
    

}
//从NSDecimalNumber转字符串  后面的样式自动根据地区计算
func formatFromDecimal(decimal:NSDecimalNumber) -> String {
    return NSNumberFormatter.localizedStringFromNumber(decimal, numberStyle: NSNumberFormatterStyle.CurrencyStyle)
}

//重写方法
// overloaded + operator to add NSDecimalNumbers
func +(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByAdding(right)
}

// overloaded * operator to multiply NSDecimalNumbers
func *(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByMultiplyingBy(right)
}

// overloaded / operator to divide NSDecimalNumbers
func /(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByDividingBy(right)
}

