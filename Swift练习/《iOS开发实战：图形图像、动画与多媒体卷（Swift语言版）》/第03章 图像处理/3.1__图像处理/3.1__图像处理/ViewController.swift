//
//  ViewController.swift
//  3.1__图像处理
//
//  Created by coco on 16/7/4.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit
let sandboxFileName = "sandbox.jpg"

class ViewController: UIViewController {
    /**图片*/
    @IBOutlet weak var image: UIImageView!
    
    @IBAction func finder(sender: UIButton) {
//        let path = NSBundle.mainBundle().resourcePath?.stringByAppendingString("/\(sandboxFileName)")
//        self.image.image = UIImage(contentsOfFile: path!)
        self.image.image = UIImage(named: "bundle.jpg")
    }
    @IBAction func sandbox(sender: UIButton) {
        let path = documentsFilePath()
        self.image.image = UIImage(contentsOfFile: path)
    }
    @IBAction func network(sender: UIButton) {
        print("点击")
        sender.enabled = false
        let url = NSURL(string: "http://pic33.nipic.com/20130907/13478874_100501441177_2.jpg")
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if let data = NSData(contentsOfURL: url!) {
                //可选类型需要使用值绑定
                self.image.image = UIImage(data: data)
                sender.enabled = true
            } else {
                sender.enabled = true
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.image.image = UIImage(named: "placeholder.png")
        self.copyImageToSandbox()
    }

    //把文件拷贝到沙盒
    func copyImageToSandbox() {
        let fileName = documentsFilePath()
        print(fileName)
        let manager = NSFileManager.defaultManager()

//注意:不是可选类型,不能使用值绑定 if let exist = manager.fileExistsAtPath(fileName) {} else {}
        if !manager.fileExistsAtPath(fileName) {
            //不存在, 拷贝到沙盒
            let defaultPath = NSBundle.mainBundle().resourcePath?.stringByAppendingString("/\(sandboxFileName)")
            do {
                _ = try manager.copyItemAtPath(defaultPath!, toPath: fileName)
            } catch  {
                print("已经存在了")
            }
        }
        
    }
    
    //获取沙盒里面文件路径
    func documentsFilePath() ->String {
        let doucumetsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        let fileName = doucumetsPath.stringByAppendingString("/\(sandboxFileName)")
        return fileName
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

