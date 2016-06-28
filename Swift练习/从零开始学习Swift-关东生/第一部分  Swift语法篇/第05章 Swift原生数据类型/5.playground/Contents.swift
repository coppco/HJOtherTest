//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var a = 2.1e2
a = 2.1E-2
a = 00000.45
a = 45___000__1


let b : UInt8 = 90
let c : UInt16 = 1300

//let total = b + c  //错误
//let total = b + UInt8(c)  大数转小数不安全  编译错误了
let total1 = UInt16(b) + c

//let d : Bool = 1  //不能使用0和1了


//元组类型
var student = ("10001", "张三", 20, "90")
student.0
student.3

var student1 = (id:"10002", name:"李四", english_score:100, chinese_score:"20")

student1.0
student1.chinese_score

let (id, name, english_score,chinese_score) = student

print("id = \(id), name = \(name), english_score = \(english_score), chinese_score = \(chinese_score)")

//可选类型, Swift默认所有的数据类型声明的常量和变量都不能为nil

var d:Int = 10
//d = nil  错误的

//let e :String = nil  //错误的

var f:Int? = nil
f = 100

var g:String! = nil
g = "gg"

//g = str + "12"

//拆包
print(f)
print(f! + 10)
print(g! + "121")

func divide(n1:Int, n2: Int)->Double? {
    if n2 == 0  {
        return nil
    }
    return Double(n1) / Double(n2)
}

if let result = divide(200, n2: 0) {
    print("success:\(result)")
} else {
//    print(result);  //编译错误
    print("failure");
}
