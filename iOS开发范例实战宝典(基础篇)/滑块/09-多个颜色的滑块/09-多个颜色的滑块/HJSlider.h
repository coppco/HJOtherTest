//
//  HJSlider.h
//  09-多个颜色的滑块
//
//  Created by coco on 16/5/31.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJSlider : UIControl
/**滑块的当前值*/
@property (nonatomic, assign)CGFloat value;
/**分割值*/
@property (nonatomic, assign)CGFloat midValue;

/**滑块划过的颜色*/
@property (nonatomic, strong) UIColor* minimumTrackTintColor;

/**进度条前面颜色*/
@property (nonatomic, strong) UIColor* middleTrackTintColor;

/**进度条后面颜色*/
@property (nonatomic, strong) UIColor* maximumTrackTintColor;

/**
 *  @author XHJ, 16-05-31 11:05:45
 *
 *  滑块的大拇指颜色
 */
@property (nonatomic, strong) UIColor* thumbTintColor;
@end
