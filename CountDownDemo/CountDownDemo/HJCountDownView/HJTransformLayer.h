//
//  HJTransformLayer.h
//  CountDownDemo
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface HJTransformLayer : CATransformLayer

/*前部*/
@property(nonatomic, strong)CALayer *topLayer;

/*后面*/
@property(nonatomic, strong)CALayer *bottomLayer;


/**
 更新内容

 @param image 图片
 @param isTop YES----->上面,  NO ------> 下面
 */
- (void)updateLayerContent:(UIImage *)image isTop:(BOOL)isTop;
@end
