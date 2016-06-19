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
    var isResult : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        resultL.adjustsFontSizeToFitWidth = true //自适应
        self.original()
    }

    //恢复初始状态
    func original() {
        firstNumber = 0.0
        secondNumber = 0.0
        isSecondNumber = false
        decimalPointFlag = false
        operatorFlag = ""
        resultL.text = "0"
        isResult = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //数字按钮点击
    @IBAction func numberTap(sender: UIButton) {
        
        if isResult {
            self.original()
        }
        
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
        if isResult {
            self.original()
        }
        
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
    
    //加减乘除
    @IBAction func operationTap(sender: UIButton) {
        if firstNumber != 0.0 {
            isSecondNumber = true
            decimalPointFlag = false
            switch sender.currentTitle! {
            case "+":
                operatorFlag = "+"
            case "-":
                operatorFlag = "-"
            case "*":
                operatorFlag = "*"
            case "/":
                operatorFlag = "/"
            default :
                operatorFlag = ""
            }
        }
    }
    //等于=
    @IBAction func resultTap(sender: UIButton) {
        if isSecondNumber {
            //除数不能为0
            if operatorFlag == "/" && secondNumber == 0.0 {
                print("除数不能为0")
                self.original()
                return
            }
            var resultNumber : Double = 0.0
            switch operatorFlag {
            case "+":
                resultNumber = firstNumber + secondNumber
            case "-":
                resultNumber = firstNumber - secondNumber
            case "*":
                resultNumber = firstNumber * secondNumber
            case "/":
               resultNumber = firstNumber / secondNumber
            default :
                resultNumber = 0.0
            }
            resultL.text = resultNumber.description
            isResult = true
        }
    }
    
    //删除
    @IBAction func deleteTap(sender: UIButton) {
        self.original()
    }
    //百分号
    @IBAction func baifen(sender: UIButton) {
    }
    //+/-
    @IBAction func revert(sender: UIButton) {
        if !isSecondNumber && firstNumber != 0.0{
            firstNumber = -firstNumber
            resultL.text = firstNumber.description
        } else if isSecondNumber && secondNumber != 0.0{
            secondNumber = -secondNumber
            resultL.text = secondNumber.description
        } else {
            return
        }

    }
    
}

