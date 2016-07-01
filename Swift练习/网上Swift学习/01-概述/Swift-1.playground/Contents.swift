//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//打印
print(str)

print("Hello, word!")

let implicitInteger = 78
let implicitDouble = 70.89
let explicitiDouble : Double
explicitiDouble = 89.92

let label = "The width is "
let width = "94"
let width1 = 94
let widthLabel = label + width
let widthLabel1 = label + String(width1)

//简单值加入到字符串
//     \(简单值)
let apples = 3
let oranges = 5
let applesSumary = "I have \(apples) apples"
let fruitSumary = "I have \(apples + oranges) pieces of fruit"

//数组
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "sky"
print(shoppingList)

//字典
var occupation = [
    "Malcolm" : "Capain",
    "Kaylee" : "Mechanic"
]
occupation["Jayne"] = "Public Relations"
print(occupation)

let emptyArray = [String]()
let emptyDictionary = [String:Float]()

//控制流
//使用 if和 switch来做逻辑判断，使用 for-in， for， while，以及 repeat-while来做循环。使用圆括号把条件或者循环变量括起来不再是强制的了，不过仍旧需要使用花括号来括住代码块。

let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0

for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print(teamScore)

//使用? 表示 值可选 意思可以为nil
var optionalString : String? = "Hello"

print(optionalString != nil)

var optionalName : String? = nil
var greeting = "Hello!"
if let name = optionalName {
//    greeting = greeting + name
    greeting = "Hello , \(name)"
    print(greeting)
} else {
    greeting = greeting + " The name is nil"
}

let nickName : String? = nil
let fullName : String = "John Appl"
let informalGreeting = "Hi \(nickName ?? fullName)"

//计算平均值的函数
func average(_ items:Int...)->Double {
    var result:Double = 0
    for item in items {
        result += Double(item)
    }
    return result / Double(items.count)
}
//使用闭包
let averageClosure:(Int...)->Double = { (items:Int...) in
    var result :Double = 0
    for item in items where item >= 7 { //使用where关键字 设置过滤条件
        result += Double(item)
    }
    return result / Double(items.count)
}
let averageClosure1:[Int]->Double = { array in
    var result :Double = 0
    for item in array {
        result += Double(item)
    }
    return result / Double(array.count)
}
averageClosure1([1,2,3,4,5,6])
averageClosure(1,2,3,4,5,6,11,11,11,11,11)
average(1,2,3,4,5,6, 7, 8, 9, 10, 11)

var numbers = [20, 19, 7, 12]
2
3
4
5
numbers.map({
    (number: Int) -> Int in
    let result = 3 * number
    return result
})

numbers.map({ (number:Int) -> Int in
    let result = number * 9
    return result
})
print(numbers)


class Person {
    var job:String?
    var name:String!
    let age:Int = 21
    
    func jobed(job:String) {
        self.job = job
    }
}

let 张三:Person = Person()
张三.job = "乞讨"
张三.name = "张三"


class YanFa {
    var  name:String  {
        willSet {
            print(name)
        }
    }//存储属性
    var  age:Int! {
        didSet {
            print(age)
        }
    }
    init(name:String, age:Int) {
        self.name = name
        self.age = age
    }
    var descript:String {  //计算属性,只有getter方法
        return "name = \(self.name), age = \(self.age)"
    }
}

let xhj:YanFa = YanFa(name: "xhj", age: 28)
xhj.name = "gtm"
print(xhj.name)

print(xhj.descript)


