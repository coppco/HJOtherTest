//
//  HJCircleSlider.h
//  08-环形滑块
//
//  Created by coco on 16/5/31.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJCircleSlider : UIControl
/**当前值*/
@property (nonatomic, assign)CGFloat value;
/**最小值*/
@property (nonatomic, assign)CGFloat minimumValue;
/**最大值*/
@property (nonatomic, assign)CGFloat maximumValue;
/**最小值颜色*/
@property(nonatomic, retain) UIColor *minimumTrackTintColor;
/**最大值颜色*/
@property(nonatomic, retain) UIColor *maximumTrackTintColor;
/**大拇指颜色*/
@property(nonatomic, retain) UIColor *thumbTintColor;
@end
