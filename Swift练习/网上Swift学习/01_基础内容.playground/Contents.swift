//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
/*
 Swift 为所有 C 和 Objective-C 的类型提供了自己的版本，包括整型值的 Int ，浮点数值的 Double 和 Float ，布尔量值的 Bool ，字符串值的 String 。如同集合类型中描述的那样， Swift 同样也为三个主要的集合类型提供了更牛逼的版本， Array ， Set 和 Dictionary 。
 除了我们熟悉的类型以外，Swift 还增加了 Objective-C 中没有的类型，比如元组。元组允许你来创建和传递一组数据。你可以利用元组在一个函数中以单个复合值的形式返回多个值。
 
 Swift 还增加了可选项，用来处理没有值的情况。
 */

//1⃣️let声明常量、var声明变量

//未指定类型,使用类型推导, 必须赋值才行
let maxNumber = 10
var currentNumber = 0

//指定类型, 可以不指定值,但是常量在使用前必须赋值一次
let welcomeMessage: String
var times: String

//常量定义的时候未赋值,在使用前要赋值一次
welcomeMessage = "123"
times = welcomeMessage
times = "456"


/*
 可以在一行中定义多个相同类型的变量, 使用逗号隔开,只在最后一个变量后面添加: 类型即可
 */

var red, green, blue: UIColor

//一般很少指定类型, 如果在定义的时候设定了一个初始值,那么Swift就会推断出它的类型


//2⃣️命名常量和变量
//常量和变量的名字几乎可以是任何字符,包括Unicode字符
//常量和变量的名字不能包含空白字符、数学符号、箭头、保留的（或者无效的）Unicode 码位、连线和制表符。也不能以数字开头，尽管数字几乎可以使用在名字其他的任何地方。
let 你好 = "hello"
let 🐶 = "狗"

//使用Swift保留的关键字,需要使用反引号~ 下面的符号把标识符前后包住
var `class` = "class"
`class` = "className"


//3⃣️输出常量和变量
//使用print()函数

print(`class`, "abc", "123", separator: "--", terminator: "+++")

//4⃣️注释 // 和 /**/

//5⃣️分号: Swift并不要求你在每一句代码结尾添加分号,但是一行里面写多句代码,分号是必须的
let cat = "🐱"; print(cat)

//6⃣️整数:没有小数的数字 
//UInt、UInt8、UInt16、UInt32、 UInt64  无符号
//Int、Int8、Int16、Int32、 Int64  //有符号

  //范围
let minValue = Int64.min  //它的最小值
let maxValue = Int64.max  //它的最大值

