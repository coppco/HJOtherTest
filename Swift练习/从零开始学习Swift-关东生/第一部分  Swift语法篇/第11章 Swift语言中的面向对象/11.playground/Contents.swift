//: Playground - noun: a place where people can play

import UIKit

//枚举
enum WeekDays {
   case Monday
   case Tuesday
   case Wednesday
   case Thursday
   case Friday
}

enum DayOff {
    case Saturday, Sunday
}

var day = WeekDays.Friday
day = WeekDays.Monday
day = .Tuesday

let funDay:(WeekDays)->Void = {
//    (a:WeekDays) in
//    switch a {
//    case WeekDays.Monday: print("星期一好!")
//    case .Tuesday: print("星期二好!")
//    case .Wednesday: print("星期三好!")
////    case .Thursday: print("星期四好!")
////    case .Friday: print("星期五好!")
//    default: print("好!")
//    }
    
//    a in
//    switch a {
//    default:print("\(a)")
//    }
    
    print($0)
}

funDay(WeekDays.Friday)
funDay(day)

enum Figure {
    case Rectangle(Int, Int)
    case Circle(Int)
}

let printFigure:(Figure)->() = {(figur:Figure) in
    switch figur {
    case let .Rectangle(width, height) : print("width = \(width), height = \(height)")
    case .Circle(let radius): print("radius = \(radius)")
    }
}
printFigure(Figure.Rectangle(199,299))
printFigure(Figure.Circle(20))


//结构体和类

//结构体

struct Department {
    var no:Int = 0                     //部门编号
    var name:String = ""         //部门名称
}
//重载运算符
func ==(a:Department, b:Department)->Bool {
    return a.name == b.name && a.no == b.no
}
func !=(a:Department, b:Department)->Bool {
    return a.name != b.name || a.no != b.no
}


//类
class Employee {
    var no:Int = 0
    var name:String = ""
    var job:String?
    var salary:Double = 0
    
    var department: Department?
}
//重载运算符
func ==(a:Employee, b:Employee)->Bool {
    return a.name == b.name && a.no == b.no && a.job! == b.job! && a.salary == b.salary && a.department! == b.department!
}
func !=(a:Employee, b:Employee)->Bool {
    return a.name != b.name || a.no != b.no || a.job! != b.job! || a.salary != b.salary || a.department! != b.department!
}
let emp = Employee()
emp.job = "iOS"
emp.name = "小王"
emp.no = 12345
emp.salary = 12000

var dept = Department()
dept.no = 100990
dept.name = "研发部"

//值类型和引用类型

//两个闭包 分别更改类和结构体
let changeEmployee:(Employee)->Void = { object in
    object.name = "小李"
}
//在函数和闭包中修改值类型,需要使用inout关键字
let changeDepartment:(inout Department)->Void = { (inout object:Department) in
    object.name = "测试部"
}

print("更新前:   \(emp.name)")
changeEmployee(emp)
print("更新后:   \(emp.name)")

print("更新前:   \(dept.name)")
changeDepartment(&dept)
print("更新后:   \(dept.name)")


//===  !==   == !=
let emp1:Employee = Employee()
let emp2:Employee = Employee()
emp1.job = "1"
emp1.name = "1"
emp1.no = 1
emp1.salary = 1
emp2.job = "1"
emp2.name = "1"
emp2.no = 1
emp2.salary = 1

if emp1 === emp2 {
    print("引用对象相等")
} else {
    print("引用对象不相等")
}
//自定义类Employee 不能使用==和!=, 需要重载运算符, 通过定义函数的方式实现

if emp1 == emp2 {
    print("值相同")
} else {
    print("值不相同")
}

var dept1:Department = Department()
var dept2:Department = Department()
dept1.no = 1
dept1.name = "1"
dept2.no = 1
dept2.name = "1"

//结构体也不能使用==和!=
if dept1 == dept2 {
    print("值类型相同")
} else {
    print("值类型不相同")
}
