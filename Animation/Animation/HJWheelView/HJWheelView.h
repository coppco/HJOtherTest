//
//  HJWheelView.h
//  HJOrange
//
//  Created by apple on 2017/3/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJWheelView : UIView
/*图片数组, 支持本地图片名和网络图片*/
@property(nonatomic, strong)NSMutableArray *imagesA;
/*是否自动播放*/
@property(nonatomic, assign)BOOL isAutoPlay;
/*轮播图间隔时间*/
@property(nonatomic, assign)NSTimeInterval timeInterval;
/*type*/
@property(nonatomic, assign)BOOL isCustomer;
@end
