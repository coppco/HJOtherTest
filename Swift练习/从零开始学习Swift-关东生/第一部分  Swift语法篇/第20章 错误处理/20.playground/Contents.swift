//: Playground - noun: a place where people can play

import UIKit
import Foundation


var str = "Hello, playground"

enum EncodingError:ErrorType {
    case EncodingOne
    case EncodingTwo
    case EncodeingThree
}
do {
    let str = try NSString(contentsOfFile: "abc", encoding: NSUTF8StringEncoding)
}catch let err as NSError{
    err.description
}

