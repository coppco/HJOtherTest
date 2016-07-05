//
//  ViewController.swift
//  3.3__滤镜CIFilter
//
//  Created by coco on 16/7/4.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

enum ImageFlag {
    case tonal  //色调
    case fuzzy //模糊
}

class ViewController: UIViewController {
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var titleL: UILabel!
    var flag:ImageFlag = .tonal
    var image:UIImage!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var haha: NSLayoutConstraint!
    //滑块
    @IBAction func slider(sender: UISlider) {
        let value :Float = sender.value
        switch self.flag {
        case .fuzzy:
            self.filterGaussianBlur(value)
        case .tonal:
            self.filterSepiaTone(value)
        }
    }
    //分段
    @IBAction func segment(sender: UISegmentedControl) {
        self.slider.value = 0.5
        if sender.selectedSegmentIndex == 0 {
            self.flag = .tonal
        } else {
            self.flag = .fuzzy
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.image = self.imageV.image
        
        /* Categories
        public let kCICategoryDistortionEffect: String
        public let kCICategoryGeometryAdjustment: String
        public let kCICategoryCompositeOperation: String
        public let kCICategoryHalftoneEffect: String
        public let kCICategoryColorAdjustment: String
        public let kCICategoryColorEffect: String
        public let kCICategoryTransition: String
        public let kCICategoryTileEffect: String
        public let kCICategoryGenerator: String
        @available(iOS 5.0, *)
        public let kCICategoryReduction: String
        public let kCICategoryGradient: String
        public let kCICategoryStylize: String
        public let kCICategorySharpen: String
        public let kCICategoryBlur: String
        public let kCICategoryVideo: String
        public let kCICategoryStillImage: String
        public let kCICategoryInterlaced: String
        public let kCICategoryNonSquarePixels: String
        public let kCICategoryHighDynamicRange: String
        public let kCICategoryBuiltIn: String
        @available(iOS 9.0, *)
        public let kCICategoryFilterGenerator: String
        */
        //获取所有滤镜
        let array = CIFilter.filterNamesInCategories([kCICategoryBlur, kCICategoryBuiltIn])
        for name in array {
            let filter = CIFilter(name: name)
            print(filter?.description)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*自定义函数 旧色调*/
    func filterSepiaTone(value:Float) {
        let context = CIContext(options: nil)  //上下文
        let cImage = CIImage(CGImage: self.image.CGImage!)  //CIImage对象
        
        let filter = CIFilter(name: "CISepiaTone") //滤镜
        filter?.setDefaults()
        filter?.setValue(cImage, forKey: "inputImage")  //设置输入图片
        
//        let text = "旧色调Intensity:\(value)"
        let text = String(format: "旧色调Intensity:%.2f", value * 10)
        self.titleL.text = text
        
        filter?.setValue(value, forKey: "inputIntensity") //设置旧色调滤镜色调强度
        let result = filter?.outputImage
//        let result = filter?.valueForKey("outputImage") as! CIImage
        let imageRef = context.createCGImage(result!, fromRect: CGRectMake(0, 0, self.image.size.width, self.image.size.height))
        
        let image = UIImage(CGImage: imageRef)
        self.imageV.image = image
    }

    /*模糊*/
    func filterGaussianBlur(value:Float) {
        let context = CIContext(options: nil)
        let cImage = CIImage(CGImage: self.image.CGImage!)
        
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setDefaults()
        filter?.setValue(cImage, forKey: "inputImage")  //设置输入图片
        
        //        let text = "旧色调Intensity:\(value)"
        let text = String(format: "高斯模糊Radius:%.2f", value  * 10)
        self.titleL.text = text
        
        filter?.setValue(value * 10, forKey: "inputRadius") //设置高斯模糊半径
        let result = filter?.outputImage
        //        let result = filter?.valueForKey("outputImage") as! CIImage
        let imageRef = context.createCGImage(result!, fromRect: CGRectMake(0, 0, self.image.size.width, self.image.size.height))
        
        let image = UIImage(CGImage: imageRef)
        self.imageV.image = image
    }
}

