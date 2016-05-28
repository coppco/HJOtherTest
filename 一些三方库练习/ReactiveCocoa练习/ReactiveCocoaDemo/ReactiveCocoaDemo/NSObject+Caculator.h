//
//  NSObject+Caculator.h
//  ReactiveCocoaDemo
//
//  Created by coco on 16/5/13.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "CaculatorMaker.h"

@interface NSObject (Caculator)
/**
 *  @author XHJ, 16-05-13 15:05:59
 *
 *  计算 
 *
 *  @param 用于计算的对象
 *
 *  @return 返回计算的数值
 */
+ (CGFloat)makeCaculators:(void(^)(CaculatorMaker *maker))block;

@end
