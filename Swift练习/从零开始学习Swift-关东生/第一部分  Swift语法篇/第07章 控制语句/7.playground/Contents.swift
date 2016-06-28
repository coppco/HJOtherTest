//: Playground - noun: a place where people can play

import UIKit

//水仙花是一个三位数 三位数各位的立方和等于其本身  求水仙花

for number in 100...999 {
    let a = number / 100
    let b = (number - a * 100) / 10
    let c = number - a * 100 - b * 10
    if number == a * a * a + b * b * b + c * c * c {
        print("第一个a = \(a), b = \(b), c = \(c)")
    }
}

label1:for var a in 1...9 {
    label2:for var b in 0...9 {
        label3:for var c in 0...9 {
            if a * a * a + b * b * b + c * c * c == a * 100 + b * 10 + c {
                print("第二个:a = \(a), b = \(b), c = \(c)")
            }
        }
    }
}

var x = 100
while (x <= 998) {
    x++
    let a = x / 100
    let b = (x - 100 * a) / 10
    let c = x - a * 100 - b * 10
    
    if x == a * a * a + b * b * b + c * c * c {
        print("第三个:a = \(a), b = \(b), c = \(c)")
    }
}

var ii = 16
repeat {
ii  /= 2
} while (ii > 3)