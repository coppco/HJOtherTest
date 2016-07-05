//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let andString1 : Character = "&"
let andString2 : Character = "\u{26}"  //Unicode编码方式

let lamda1 = "λ"    //不指定类型, 默认是String 类型
let lamda2 = "\u{03bb}"

let smile1:Character = "😃"
let smile2:Character = "\u{0001f603}"

//let haha:Character = "^^"  //字符是一个长度的, 编译错误


//字符串

var eeeee  = "你好!"
eeeee.characters.count
//eeeee += "121"   //错误的
//eeeee = eeeee + "121"   //let声明的字符串是不可变字符串,不能拼接 追加等
var dddd  = eeeee + "    2321"

dddd += "  哈哈"

dddd.append(Character.init("a"))

var a = "我垫付都是开发"

a += "a"
var b: Character = "c"
a.append(b)

var name = "张三"
name = "我叫\(name)"
"我叫"+name

name.insert("c", atIndex: name.endIndex)
name.removeAtIndex(name.endIndex.predecessor())
print(name)
name.removeRange(name.startIndex..<name.endIndex.predecessor())

name += "对方收到了飞机上的了"

name.replaceRange(name.startIndex...name.startIndex.successor(), with: "四")

var x = "ddd"
var y = "dd"

if x == y {
    print("x(\(x)) == y(\(y))")
} else {
    print("x(\(x)) != y(\(y))")
}

if x > y {
    print("x(\(x)) > y(\(y))")
} else {
    print("x(\(x)) <= y(\(y))")
}


//前后缀

var z:String = "Swift.playground"
var zz:String = "是大幅度的方法都是"
z.hasPrefix("Swift")
z.hasSuffix("playground")

z.lowercaseString
z.uppercaseString


z == zz
//z === zzz   //编译错误

var abc1 : NSString = "123"
var abc2 : NSString = "123"

abc1 === abc2
abc1 == abc2
