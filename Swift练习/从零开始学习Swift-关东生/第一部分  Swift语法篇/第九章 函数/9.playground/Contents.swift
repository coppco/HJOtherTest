//: Playground - noun: a place where people can play

import UIKit
// W H  是外部参数名  可以省略的
//长方形面积
func recctangleAear(W width:Double = 100, H height:Double = 100) ->Double {
    return width * height
}


print("320 * 480的长方形面积是:\(recctangleAear(W: 320, H: 480))")

print(recctangleAear())

//函数参数不固定
func sum(numbers:Double...) ->Double {
    var total :Double = 0
    for number in numbers {
        total += number
    }
    return total
}
sum(1,2,3,4,5,6,7)

func increment(inout value:Double, amount:Double = 1) {
    value += amount
}
var value:Double = 10
increment(&value)  //参数有默认值 可以不传递参数
increment(&value, amount: value)


//多返回值

func position(dt:Double, speed:(x:Int, y:Int)) ->(x:Int, y:Int) {
    let posX = Int(dt) * speed.0
    let posY = Int(dt) * speed.y
    return (posX, posY)
}

position(100, speed: (2, -4))


//三角形面积
func triangleArea(bottom:Double, height:Double) ->Double {
    return 0.5 * bottom * height
}
//函数作为返回类型使用
func getArea(type:String) -> (Double, Double) ->Double {
    var function:(Double, Double)->Double
    switch type {
    case "rect": function = recctangleAear
    case "tria": function = triangleArea
    default : function = recctangleAear
    }
    return function
}

var area : (Double, Double)->Double = getArea("tria")

print("底:15, 高20的面积是:\(area(15, 20))")


//函数作为参数使用

func getAreaByFunc(funcName:(Double, Double) ->Double, a:Double, b:Double) ->Double {
    let area = funcName(a,b)
    return area
}

getAreaByFunc(recctangleAear, a: 10, b: 10)
getAreaByFunc(triangleArea, a: 10, b: 10)

//函数的嵌套

func calculate(opr:String) ->(Double, Double) -> Double {
    func add(x:Double, _ y:Double) ->Double {
        return x + y
    }
    func sub(x:Double,_ y:Double) ->Double {
        return x - y
    }
    
    var funcName:(Double, Double) ->Double
    switch opr {
        case "+": funcName = add
        case "-": funcName = sub
    default: funcName = add
    }
    return funcName
}

var opt1:(Double, Double) ->Double = calculate("+")

opt1(21, 10)

opt1 = calculate("-")

opt1(21, 10)



