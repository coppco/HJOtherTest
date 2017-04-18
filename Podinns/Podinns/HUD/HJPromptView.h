//
//  HJPromptView.h
//  HJOrange
//
//  Created by apple on 2017/2/22.
//  Copyright © 2017年 apple. All rights reserved.
//  在window上面显示提示view, 不影响操作, 只是做提示作用

#import <UIKit/UIKit.h>

@interface HJPromptView : UIView


/**
 显示提示框

 @param imageName 图片名称, 可以没有
 @param message 显示提示消息 
 */
+ (void)showImage:(NSString *)imageName message:(NSString *)message;

@end
