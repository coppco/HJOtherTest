//: Playground - noun: a place where people can play

import UIKit

//闭包
//    {(参数1:String, 参数2:String) ->String(返回值) in
//        语句组
//}
func calculate11(type:String) -> (Int, Int) ->Int {
        var result:(Int, Int)->Int
        switch type {
        case "+": result = {(a:Int, b:Int)->Int in return a + b}
        case "-": result = {(a, b) in return a - b}
        case "*": result = {$0 * $1}
        default : return {a, b in return a / b  + 10}
        }
        return result
//    return {(a:Int, b:Int)->Int in return a + b}
}

calculate11(".")(10, 12)
calculate11("*")(10, 18)

//使用闭包的返回值
let xxx:Int = {
     $0 * $1 + 10  //使用$0,$1等参数名和in都必须省略,  return可以不省略
}(10, 10)


func xhj(type:String, fun:(Int, Int)->Int) {
    switch type {
    case "+": print("10 + 5 = \(fun(10, 5))")
    default: print("14 - 6 = \(fun(14, 6))")
    }
}

xhj("+", fun:{(a:Int, b:Int)->Int in return a + b})
xhj("-"){(a:Int, b:Int)-> Int in a - b}

xhj("-"){a,b in return a - b}
xhj("a"){a,b in return a * b}
xhj("1"){$0 / $1}


//捕捉上下文中的变量和常量

func makeArray() ->(String)->[String] {
    var array:[String] = [String]()
    /*
    func addElement(e:String)->[String] {
    array.append(e)
    return array
    }
    return addElement
    */
    return {(a:String)->[String] in
        array.append(a)
        return array  //return array.append(a)这两句不能连这写,因为函数func append()没有返回值
    }
}
let m1 = makeArray()
m1("呵呵")
m1("李四")

//定义一个函数类型,  赋值闭包
let DoMath:(Int, Int)->Int = {
    return $0 + $1
}
DoMath(3, 2)
DoMath(110, 443)
