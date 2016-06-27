//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var score = 81
if score >= 80 {
    print("优秀")
}
if score < 60 {
    print("不及格")
} else {
    print("及格")
}

if score < 60 {
    print("不及格")
} else if score < 80 {
    print("及格")
} else {
    print("优秀")
}

switch score / 10 {
    case 10:print("满分")
    case 9,8:print("优秀")
    case 7,6:print("及格")
    default:print("差")
}

//guard
struct Blog {
    let name:String?
    let age:String?
    let auther:String?
    init(name:String, age:String, auther:String) {
        self.name = name
        self.age = age
        self.auther = auther
    }
}

var blog1 = Blog(name: "张三的歌", age: "20", auther:"张三")

print(blog1.name!)

func guardLongStyleBlog(blog:Blog) {
    guard let name = blog.name else {
        print("没有名字!")
        return
    }
    print("名字是:\(name)")
    
    guard let age = blog.age else {
        print("没有年龄!")
        return
    }
    print("年龄是:\(age)")
    
    guard let auther = blog.auther else {
        print("没有作者!")
        return
    }
    print("作者是:\(auther)")
}

guardLongStyleBlog(blog1)

var i = 0
while let name = blog1.name {
    print(name)
    i += 2
    if i >= 200 {
        break
    }
}

var j :Int64 = 0
//while j * j < 100___000 {
//    j++
//}

while j++ * j++ < 100_____000 {
    j
}


let numbers = [1,2,3,4,5,6,7,8,9,10]
for (index, element) in numbers.enumerate() {
    print("\(index) = \(element)")
}
let items = [1,2,3,4,5,6,7,8,9,10]
for item in items where item > 5 {
    print(item)
}

label1:for var x = 0; x < 5; x++ {
    label2:for var y = 5; y > 0 ;y-- {
        if x == y {
            break label1
        }
        print("(x,y) = (\(x), \(y))")
    }
}

struct Student {
    let id:String
    let name:String
    let age:String
    let chineseScore:Int16
    let englishScore:Int16
    init(id:String, name:String, age:String, chineseScore:Int16, englishScore:Int16) {
        self.id = id
        self.name = name
        self.age = age
        self.chineseScore = chineseScore
        self.englishScore = englishScore
    }
}

var studen:Student = Student(id: "1001", name: "张三", age: "21", chineseScore: 80, englishScore: 90)
var studen1 = (id:"1001", name:"张三", age:"21", chineseScore:90, englishScore:91)

var desc: String
switch studen1 {
case (_, _, _, 90...100,  90...100): desc = "优秀"
default: desc = "无"
}




