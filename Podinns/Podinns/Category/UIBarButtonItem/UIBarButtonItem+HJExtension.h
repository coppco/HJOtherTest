//
//  UIBarButtonItem+HJExtension.h
//  Podinns
//
//  Created by apple on 2017/3/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HJExtension)

/**
 通过UIButton创建UIBarButtonItem对象

 @param title 标题
 @param normalColor 正常在下标题颜色
 @param highlightedColor 高亮状态下标题颜色
 @param normalImage 正常状态下图片
 @param highlightedImage 高亮状态下图片
 @param target 目标
 @param action 方法
 @param edg 内边距
 @return 返回UIBarButtonItem对象
 */
+ (instancetype)barButtonItemWithTitle:(NSString *)title titleNormalColor:(UIColor *)normalColor titleHighlightedColor:(UIColor *)highlightedColor normalImage:(NSString *)normalImage highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action edg:(UIEdgeInsets)edg;
@end
