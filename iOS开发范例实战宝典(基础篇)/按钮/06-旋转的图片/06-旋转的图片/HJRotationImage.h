//
//  HJRotationImage.h
//  06-旋转的图片
//
//  Created by coco on 16/5/30.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJRotationImage : UIView
/*需要旋转的图片*/
@property (nonatomic, strong)UIImageView *imageV;
/**
 *  @author XHJ, 16-05-30 15:05:09
 *
 *  开始旋转
 */
- (void)startRotation;
/**
 *  @author XHJ, 16-05-30 15:05:15
 *
 *  停止旋转
 */
- (void)stopRotation;
/**
 *  @author XHJ, 16-05-30 17:05:23
 *
 *  判断是否正在旋转
 *
 *  @return YES 正在旋转
 */
- (BOOL)isRotationAnimation;
@end
