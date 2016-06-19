//: Playground - noun: a place where people can play

import UIKit

var string = "hello" + " " + "world"

for i in 0..<10 {
    string += "\(i)"
}
string
for i in 0..<20 {
    var j = i % 4
}
let color = UIColor.blueColor()
let attribStr = NSAttributedString(string: string, attributes: [NSForegroundColorAttributeName : color,
    NSFontAttributeName : UIFont.systemFontOfSize(32)])

let imageNames = ["1", "2", "3","4","5","6"]
let images = imageNames.map {UIImage(named: $0 + ".jpg")}
images
let image = images[2]
let imageView = UIImageView(image: image);
imageView.frame = CGRectMake(0, 0, 208, 312)

//绝对路径
let absolePath = å
