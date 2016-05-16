//
//  CaculatorMaker.h
//  ReactiveCocoaDemo
//
//  Created by coco on 16/5/13.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface CaculatorMaker : NSObject
/*结果*/
@property (nonatomic, assign)CGFloat result;

/**
 *  @author XHJ, 16-05-13 15:05:06
 *
 *  加法计算   返回值是一个block
 */
- (CaculatorMaker * (^)(CGFloat))add;

/**
 *  @author XHJ, 16-05-13 16:05:01
 *
 *  减法计算  返回一个block(block  返回值就是自己本身,参数是要操作的数字)
 */
- (CaculatorMaker *(^)(CGFloat))sub;
/**
 *  @author XHJ, 16-05-13 16:05:17
 *
 *  乘法计算  返回一个block
 */
- (CaculatorMaker *(^)(CGFloat))muilt;
/**
 *  @author XHJ, 16-05-13 16:05:45
 *
 *  除法计算  返回一个block
 */
- (CaculatorMaker *(^)(CGFloat))divide;

- (CaculatorMaker *)and;
- (CaculatorMaker *)with;
@end
