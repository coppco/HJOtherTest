//
//  ViewController.swift
//  3.4__人脸识别CIDetector
//
//  Created by coco on 16/7/5.
//  Copyright © 2016年 XHJ. All rights reserved.
//
/*
人脸识别步骤:
    1⃣️建立人脸的面纹数据库
    2⃣️获取当前人脸面像图片,生成面纹编码
    3⃣️用当前的面纹编码与数据库中面纹编码进行对比
    CIDetector类用于人脸特征识别,用过它还可以获取眼睛和嘴的信息.但是它并不包括面纹编码提取,面纹编码提取还需要更为复杂的算法处理.
    OpenCV  一个C开源的图像处理和识别库,提供了很多算法
    Face.com  一个在线的人脸识别服务,注册Key,才可以使用REST Web Service风格的API

    warning:这里只是使用CIdetector识别人脸
*/

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //输入图片
    @IBOutlet weak var inputImageV: UIImageView!
    //文字
    @IBOutlet weak var numberL: UILabel!
    //集合视图
    @IBOutlet weak var collectionView: UICollectionView!
    var faceArray:NSMutableArray!  //存放人脸图片
    
    //UIImagePickerController
    var imagePicker:UIImagePickerController!
    
    //识别
    @IBAction func recognize() {
        let context = CIContext(options: nil)
        let imageInput = self.inputImageV.image
        if imageInput == nil {
            self.numberL.text = "没有识别图片,请先选择图片"
            return
        }
        let image = CIImage(CGImage: (imageInput?.CGImage)!)
        
        //设置参数
        let param = [CIDetectorAccuracyHigh:CIDetectorAccuracy]
        
        //声明CIDetector,并设置识别类型  //里面有人脸, 矩形, 条形码 text
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: param)
        
        //取得识别结果
        let detectorResult = faceDetector.featuresInImage(image)
        
        /*
        let resultView = UIView(frame: (self.inputImageV?.frame)!) //方框
        self.inputImageV.superview!.addSubview(resultView)
        for item in detectorResult {
            let faceFeature = item as! CIFaceFeature
            //脸部
            let faceView = UIView(frame: faceFeature.bounds)
            faceView.layer.borderColor = UIColor.orangeColor().CGColor
            faceView.layer.borderWidth = 1
            resultView.addSubview(faceView)
            
            //左眼
            if faceFeature.hasLeftEyePosition {
                let leftEyeView = UIView(frame: CGRectMake(0,0,5,5))
                leftEyeView.center = faceFeature.leftEyePosition
                leftEyeView.layer.borderWidth = 1
                leftEyeView.layer.borderColor = UIColor.redColor().CGColor
                resultView.addSubview(leftEyeView)
            }
            
            //左眼
            if faceFeature.hasRightEyePosition {
                let rightEyeView = UIView(frame: CGRectMake(0,0,5,5))
                rightEyeView.center = faceFeature.rightEyePosition
                rightEyeView.layer.borderWidth = 1
                rightEyeView.layer.borderColor = UIColor.greenColor().CGColor
                resultView.addSubview(rightEyeView)
            }
            
            //嘴巴
            if faceFeature.hasMouthPosition {
                let mouthView = UIView(frame: CGRectMake(0,0,5,5))
                mouthView.center = faceFeature.mouthPosition
                mouthView.layer.borderWidth = 1
                mouthView.layer.borderColor = UIColor.blueColor().CGColor
                resultView.addSubview(mouthView)
            }
        }
        
        resultView.transform = CGAffineTransformMakeScale(1, -1)
        */
        self.faceArray.removeAllObjects()
        if detectorResult.count > 0 {
            for (index, item) in detectorResult.enumerate() {
//                let faceImage = image.imageByCroppingToRect(detectorResult[index].bounds)
                let faceImage = image.imageByCroppingToRect(item.bounds)
                let face = UIImage(CGImage: context.createCGImage(faceImage, fromRect: faceImage.extent))
                /*
                if index == 0 {
                    self.outputImageV.image = face
                }
                if index == 1 {
                    self.outputImageV1.image = face
                }
                if index == 2 {
                    self.outputImageV2.image = face
                }
                */
                
                self.faceArray.addObject(face)
            }
            self.numberL.text = String(format: "识别到人脸数:%d", detectorResult.count)
        } else {
            self.numberL.text = "没有识别到人脸"
        }
        self.collectionView.reloadData() //刷新数据
    }
    //打开
    @IBAction func open(sender: AnyObject) {
        let alertVC = UIAlertController(title: "选择照片来源", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let actionCaera = UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            self.numberL.text = ""
            self.imagePicker.sourceType = .Camera
            if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                self.presentViewController(self.imagePicker, animated: true, completion: nil)
            }
        }
        
        let actionLibrary = UIAlertAction(title: "相册", style:UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            self.numberL.text = ""
            self.imagePicker.sourceType = .PhotoLibrary
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                self.presentViewController(self.imagePicker, animated: true, completion: nil)
            }
        }
        
        let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alertVC.addAction(actionCaera)
        alertVC.addAction(actionLibrary)
        alertVC.addAction(cancel)
        self.presentViewController(alertVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.imagePicker == nil {
            self.imagePicker = UIImagePickerController()
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
        }
        if self.faceArray == nil {
            self.faceArray = NSMutableArray()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //TODO:imagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        self.inputImageV.image = image
        self.imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}

       //TODO:延展中继承协议
extension ViewController:UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.faceArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HJImageCell", forIndexPath: indexPath) as! HJImageCell
        let image = self.faceArray[indexPath.item]
        cell.imageV.image = image as? UIImage
        return cell
    }
}
