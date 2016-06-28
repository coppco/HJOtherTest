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

//类
class Employee {
    var no:Int = 0
    var name:String = ""
    var job:String?
    var salary:Double = 0
    
    var department: Department?
}

let emp = Employee()
let dept = Department()
