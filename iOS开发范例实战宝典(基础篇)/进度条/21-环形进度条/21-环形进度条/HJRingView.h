//
//  HJRingView.h
//  21-环形进度条
//
//  Created by coco on 16/6/1.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJRingView : UIView
/**圆环颜色*/
@property (nonatomic, strong)UIColor *trackTintColor;

/**进度条颜色*/
@property (nonatomic, strong)UIColor *progressTintColor;

/**进度值*/
@property (nonatomic, assign)CGFloat progress;

/**进度条宽度*/
@property (nonatomic, assign)CGFloat progressWidth;

- (void)setProgress:(CGFloat)progress animation:(BOOL)animation;

@end
