//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
//泛型函数
func isEquals<T:Comparable> (a:T, _ b:T) -> Bool {
    return a == b
}

let a = 10, b = 20
let c = "a", d = "a"
isEquals(a, b)
isEquals(c, d)

//泛型类型
struct Queue<T> {
    var items = [T]()
    mutating func queue(item:T) {
        items.append(item)
    }
    
    mutating func dequeue() ->T? {
        if items.isEmpty {
            return nil
        } else {
            return items.removeAtIndex(0)
        }
    }
}


var genericQueue = Queue<String>()
genericQueue.queue("a")
genericQueue.queue("b")
genericQueue.queue("c")
genericQueue.queue("d")

genericQueue.dequeue()
genericQueue.dequeue()
genericQueue.dequeue()
genericQueue.dequeue()
genericQueue.dequeue()


//泛型扩展
extension Queue {
    func peek(position:Int) ->T? {
        if position < 0 || position >= items.count {
            return nil
        } else {
            return items[position]
        }
    }
}

genericQueue.queue("1")
genericQueue.queue("2")
genericQueue.queue("3")
genericQueue.queue("4")

genericQueue.peek(2)