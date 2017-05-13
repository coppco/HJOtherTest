//
//  UIView+HJExtersion.h
//  HJOrange
//
//  Created by apple on 2017/2/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HJExtension)
/**
 从一个hex字符串, 返回一个颜色对象
 
 @param hex 字符串#/0X/0x + (3位, 4位, 6位, 8位)
 @return 颜色
 */
+ (instancetype)colorFromHexString:(NSString *)hex;

/**
 从RGB值获取颜色

 @param RGB 0x121212 0X121212
 @return 颜色
 */
+ (instancetype)colorFromRGBValue:(uint32_t)RGB;

/**
 从RGBA值获取颜色
 
 @param RGBA 0x121212 0X121212
 @return 颜色
 */
+ (instancetype)colorFromRGBAValue:(uint32_t)RGBA;

/**
 从 R,G,B,A值(0~255)获取颜色

 @param r red
 @param g green
 @param b blue
 @param a alpha
 @return 颜色
 */
+ (instancetype)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a;
/**
 从 R,G,B值(0~255)获取颜色
 
 @param r red
 @param g green
 @param b blue
 @return 颜色
 */

+ (instancetype)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b;

/**
 随机颜色

 @return 颜色
 */
+ (instancetype)randomColor;

@end
