//
//  HJFlipNumberView.h
//  CountDownDemo
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJFlipNumberView : UIView

/*当前数字(0~9)*/
@property(nonatomic, assign)NSInteger currentNumber;

/*总共数字(0~9, 要大于等于currentNumber)*/
@property(nonatomic, assign)NSInteger totalNumber;


/**
 初始化方法

 @param currentNumber 当前数字
 @param totalNumber 总共数字
 @return 返回HJFlipNumberView对象
 */
- (instancetype)initWithCurrentNumber:(NSInteger)currentNumber totalNumber:(NSInteger)totalNumber;


/**
 初始化方法

 @param frmae 位置
 @param currentNumber 当前数字
 @param totalNumber 总共数字
 @return 返回HJFlipNumberView对象
 */
- (instancetype)initWithFrame:(CGRect)frmae currentNumber:(NSInteger)currentNumber totalNumber:(NSInteger)totalNumber;


/**
 开始翻转
 */
- (void)startFlip;

/**
 结束翻转
 */
- (void)endFlip;
@end
