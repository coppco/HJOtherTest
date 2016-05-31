//
//  HJSlider.m
//  09-多个颜色的滑块
//
//  Created by coco on 16/5/31.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJSlider.h"


@interface HJSlider ()
/*滑块*/
@property (nonatomic, strong)UISlider *slider;

/*进度条*/
@property (nonatomic, strong)UIProgressView *progressView;
@end

@implementation HJSlider

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubView];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configSubView];
    }
    return self;
}
- (void)configSubView {
    self.backgroundColor = [UIColor clearColor];
    self.slider = [[UISlider alloc] init];
    [self addSubview:self.slider];
    
    self.progressView = [[UIProgressView alloc] init];
    
    [self.slider addSubview:self.progressView];
    [self.slider sendSubviewToBack:self.progressView];
    
    //这已经不能少 不然滑块颜色会遮挡进度条的颜色
    self.slider.maximumTrackTintColor = [UIColor clearColor];
}
- (void)layoutSubviews {
    self.slider.frame = self.bounds;
    self.progressView.frame = CGRectMake(2, 0, self.slider.frame.size.width - 4, self.slider.frame.size.height);
    self.progressView.center = self.slider.center;
}
#pragma - mark setter和getter方法
- (CGFloat)value {
    return _slider.value;
}
- (void)setValue:(CGFloat)value {
    
    self.slider.value = value;
}
- (CGFloat)midValue {
    return _progressView.progress;
}
- (void)setMidValue:(CGFloat)midValue {
    _progressView.progress = midValue;
}
- (UIColor *)minimumTrackTintColor {
    return _slider.minimumTrackTintColor;
}
- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor {
    _slider.minimumTrackTintColor = minimumTrackTintColor;
}

- (UIColor *)middleTrackTintColor {
    return _progressView.progressTintColor;
}
- (void)setMiddleTrackTintColor:(UIColor *)middleTrackTintColor {
    _progressView.progressTintColor = middleTrackTintColor;
}

- (UIColor *)maximumTrackTintColor {
    return _progressView.trackTintColor;
}
- (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor {
    _progressView.trackTintColor = maximumTrackTintColor;
}

- (UIColor *)thumbTintColor {
    return _slider.thumbTintColor;
}
- (void)setThumbTintColor:(UIColor *)thumbTintColor {
    _slider.thumbTintColor = thumbTintColor;
}
@end
