//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*
//方法和函数的区别
1⃣️方法的调用前面需要有主体,而函数不用
2⃣️方法是在枚举、结构体和类内部定义的
3⃣️方法命名规范和函数不同
*/

//函数
func DoMathWithNumber(number1:Int, _ number2:Int)->Int {
    return number1 + number2
}

//函数调用的时候第一个外部参数名省略.如果后面的也想省略 使用_
//DoMathWithNumber(10, number2: 20)
DoMathWithNumber(10, 20)

//方法是在  类 枚举 结构体内部定义的

class Person {
    var name:String!
    var age:Int!
    var sex:String!
    //方法
    func letItGo() {
        print("name = \(self.name), age = \(age), sex = \(sex)")
    }
}

let xhj:Person = Person()
xhj.name = "xhj"
xhj.age = 12
xhj.sex = "男"

xhj.letItGo()
print("\(xhj.name ?? "abc")")
