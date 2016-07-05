//: Playground - noun: a place where people can play

import UIKit
//类
class Person {
    var name:String = ""
    var age:Int = 0
    //重载init方法后,如果没有重载init() 无参方法,那么默认构造函数Person()不能使用了
    init(name:String, age:Int) {
        self.name = name
        self.age = age
    }
    init() {
        name = "a"
        age = 12
    }
    deinit {
        name = ""
        age = 0
    }
}

let gtm = Person()
let xhj = Person.init(name: "xhj", age: 3)
let xhj1 = Person(name: "xhj", age: 3)
//结构体
struct Car {
    var name:String = ""
    var price:Int = 0
}

let car:Car = Car(name: "奥迪", price: 1212121)


func choseStepFunction(backwards:Bool) -> (Int) -> Int {
    /*
    func stepForward(input:Int) ->Int { return input + 1 }
    func stepBackward(input:Int) ->Int { return input - 1 }
    return backwards ? stepBackward : stepForward
*/
    //({(input : Int) in return input + 1})
    return backwards ? ({input in input - 1}) : {$0  + 1}
    
}

var currentValue = -4

let moveNearToZero = choseStepFunction(currentValue > 0)

moveNearToZero(10)

while currentValue != 0 {
//    currentValue = moveNearToZero(currentValue)
    currentValue = choseStepFunction(currentValue > 0)(currentValue)
}

func someFunctionWithEscapingClosure(function:()->Void) {
    function
}
func someFunctionWithNoescapeClosure(function:()->Void) {
    function
}
class SomeClass {
    var x = 10
    func doSomething() {
        //这个是函数吗?  尾随闭包?
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNoescapeClosure { x = 200}
    }
}

