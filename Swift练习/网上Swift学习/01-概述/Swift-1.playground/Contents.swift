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


