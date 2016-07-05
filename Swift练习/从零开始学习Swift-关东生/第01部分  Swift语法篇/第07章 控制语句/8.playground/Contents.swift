//: Playground - noun: a place where people can play

import UIKit

var studentList1:Array<String> = ["张三", "李四", "王五", "东流"]
studentList1.append("熊大")
studentList1.insert("熊二", atIndex: 0)
studentList1[2] = "对对对"
print(studentList1)
var studentList2:[String] = ["张三", "李四", "王五", "东流"]

let studentList3:[String] = ["张三", "李四", "王五", "东流"]
 //studentList3.append("232")   //不可变数组不能添加删除插入等
var studentList4  = [String]()  // 初始化了
var studentList6 = Array<String>()
for item in studentList3 {
    print(item)
}

for (index, item) in studentList3.enumerate() {
    print("index:\(index) = item:\(item)")
}

var studentList5:[Int:String]
var studentList7:Dictionary<Int, String>
var studentDictionary:[String:String] = ["101":"张三", "102":"李四", "103":"王五"]

for key in studentDictionary.keys {
    print(key)
}

for value in studentDictionary.values {
    print(value)
}

for (key, value) in studentDictionary {
    print("key = \(key), value = \(value)")
}
studentDictionary.keys.contains(<#T##element: String##String#>)
