//
//  FillingView.swift
//  2.1__FillingRect
//
//  Created by coco on 16/7/4.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class FillingView: UIView {

    override func drawRect(rect: CGRect) {
        UIColor.brownColor().setFill() // setFill  填充颜色
        UIRectFill(rect) // 绘制填充
        
        UIColor.whiteColor().setStroke()  //setStroke  描边颜色
        let frame = CGRectMake(100, 100, 100, 100)
        UIRectFrame(frame)  // 绘制描边
        
        //NSString绘制
        let title:NSString = "我的项目"
        let font = UIFont.systemFontOfSize(17)
        let attr = [NSFontAttributeName:font]
        
        title.drawAtPoint(CGPointMake(50, 50), withAttributes: attr)
        
        //UIImage绘制
        let image = UIImage(named: "a.png")
        image?.drawInRect(CGRectMake(100, 230, 100, 100))
        
        
        //图形上下文
        let context = UIGraphicsGetCurrentContext()
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)//设置描边颜色
        CGContextSetFillColorWithColor(context, UIColor.greenColor().CGColor) //填充颜色
        CGContextMoveToPoint(context, 100, 340) //移动到点
        CGContextAddLineToPoint(context, 10, 400)  //添加线
        CGContextAddLineToPoint(context, 300, 400)
        CGContextClosePath(context)  //闭合路径
//        CGContextStrokePath(context) //描边
        CGContextSaveGState(context)
        CGContextRestoreGState(context)
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
      
//        CATransform3D  //动画相关的
        //仿射变换
//        CGAffineTransformMakeRotation(<#T##angle: CGFloat##CGFloat#>) //旋转
//        CGAffineTransformMakeScale(<#T##sx: CGFloat##CGFloat#>, <#T##sy: CGFloat##CGFloat#>) //缩放
//        CGAffineTransformMakeTranslation(<#T##tx: CGFloat##CGFloat#>, <#T##ty: CGFloat##CGFloat#>) //平移
//        CGContextConcatCTM(<#T##c: CGContext?##CGContext?#>, <#T##transform: CGAffineTransform##CGAffineTransform#>) //连接到CTM变换矩阵
    
        //CTM变换矩阵
//        CGContextScaleCTM(<#T##c: CGContext?##CGContext?#>, <#T##sx: CGFloat##CGFloat#>, <#T##sy: CGFloat##CGFloat#>)  //缩放
//        CGContextRotateCTM(<#T##c: CGContext?##CGContext?#>, <#T##angle: CGFloat##CGFloat#>)  //旋转
//        CGContextTranslateCTM(<#T##c: CGContext?##CGContext?#>, <#T##tx: CGFloat##CGFloat#>, <#T##ty: CGFloat##CGFloat#>) //平移
        
        
    }
}
