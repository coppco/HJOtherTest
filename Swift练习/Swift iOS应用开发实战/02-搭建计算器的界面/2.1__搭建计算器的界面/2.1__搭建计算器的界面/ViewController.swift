//
//  ViewController.swift
//  2.1__搭建计算器的界面
//
//  Created by M-coppco on 16/6/19.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultL: UILabel!
    var firstNumber : Double = 0.0  //第一个数字
    var secondNumber : Double = 0.0  //第二个数字
    var decimalPointFlag : Bool = false   //小数点标记
    var isSecondNumber : Bool = false  //是否输入了第二个数
    var operatorFlag : String = ""  //操作符

    override func viewDidLoad() {
        super.viewDidLoad()
        resultL.adjustsFontSizeToFitWidth = true //自适应
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //数字按钮点击
    @IBAction func numberTap(sender: UIButton) {
        //清空数字
        if resultL.text == "0" || (isSecondNumber && secondNumber == 0.0) {
            self.resultL.text = ""
        }
        //显示文本
        resultL.text = resultL.text!  + sender.currentTitle!
        if isSecondNumber {
            secondNumber = (resultL.text! as NSString).doubleValue
        } else {
            firstNumber = (resultL.text! as NSString).doubleValue
        }
        print(firstNumber, secondNumber)
    }
    //小数点
    @IBAction func decimalPoint(sender: UIButton) {
        //最开始状态decimalPointFlag为false, 那么会进入方法中,在结果中添加小数点,然后decimalPointFlag状态为true, 以后点击. 都不会再拼接点了
        if !decimalPointFlag {
            resultL.text = resultL.text! + "."
            
            if isSecondNumber {
                secondNumber = (resultL.text! as NSString).doubleValue
            } else {
                firstNumber = (resultL.text! as NSString).doubleValue
            }
            
            decimalPointFlag = !decimalPointFlag
        }
    }
    
}

