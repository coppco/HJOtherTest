//: Playground - noun: a place where people can play

import UIKit

//算术运算符 -(取反)、++(自增)、—(自减) +、-、*、/和%   +=、-=、*=、/=和%=
var result = 1 + 2
result = result + 5



print(result++)
print(result)
print(++result)

result = result - 3

result = result * 7

result = result / 3

result = result % 5

result += 10

result -= 4

result *= 5

result /= 2

result %= 4

//关系运算符  ==、!=、>、<、>=、<=、===和!==
var button1 : UIButton = UIButton();
var button2 : UIButton = UIButton();
var button3 = button2

button1 === button2

button2 === button3

//逻辑运算符  !(逻辑反)、||(逻辑或)、&&(逻辑与)

let aaa : Bool = true
let bbb : Bool = false
let x = 10

let y = 9

!aaa
!bbb

x > y && aaa //都为真才为真
x < y && aaa
x > y && bbb
x < y && bbb

x > y || aaa
x < y || aaa
x > y || bbb
x < y || bbb  //都未假才为假

//位运算符  &、|、^、~、>>、<<

let xx : UInt8 = 0b10110010
let yy : UInt8 = 0b01011110
let zz : UInt8 = 0b11101100


~xx  //位反
~yy

xx&yy    // 位与

xx|yy  //位或
xx^yy  //位异或

xx>>1  //0b1011001
xx>>2  //0b101100

yy<<1 //0b010111100
yy<<2 //0b01111000
0b01111000



var x1 = 6, y1 = 8
var b : Bool

//b = x1 > y1 && x1++ > --y1
//b = x1++ > --y1 && x1 > y1
print(x1, y1)

var ac = 3.5, bc = 4.6, cc = 5.7

ac < bc && !(ac > cc)
ac != bc

16 / 2^2
16>>2
16*4
16<<2
var h : String = "123" , j : String = "123"
//var h : NSString = "123" , j : NSString = "123"
print(h===j)
h = j
print(h===j)

