//
//  ViewController.m
//  ImageView
//
//  Created by coco on 16/5/26.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"1.jpg"]; //图片
    
    //转换高度:新高度
    CGFloat height = (self.view.frame.size.width - 10) * image.size.height / image.size.width;

     //也可以 压缩图片
    UIImage *newImage = [self image:image scaleToSize:CGSizeMake(self.view.frame.size.width, height)];
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:self.view.bounds]; //滚动图
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, self.view.frame.size.width - 10,height)];//显示图片
    
//    imageV.contentMode = UIViewContentModeScaleAspectFit; //图片的模式等比缩放
    //使用原来图片的也可以
    imageV.image = image;
    
    //使用压缩后的图片也可以
//     imageV.image = newImage;
    
    [scrollview addSubview:imageV];
    scrollview.contentSize = CGSizeMake(0,height );
    [self.view addSubview:scrollview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIImage *)image:(UIImage *)image scaleToSize:(CGSize)size {
    CGImageRef imgRef = image.CGImage;
    CGSize originSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef)); // 原始大小
    if (CGSizeEqualToSize(originSize, size)) {
        return image;
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);//[UIScreen mainScreen].scale
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
//等比
- (UIImage *)image:(UIImage *)image scaleWithRatio:(CGFloat)ratio {
    CGImageRef imgRef = image.CGImage;
    
    if (ratio > 1 || ratio <= 0) {
        return image;
    }
    
    CGSize size = CGSizeMake(CGImageGetWidth(imgRef) * ratio, CGImageGetHeight(imgRef) * ratio); // 缩放后大小
    
    return [self image:image scaleToSize:size];
}
@end
