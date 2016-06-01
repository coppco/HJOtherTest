//
//  HJRingView.m
//  21-环形进度条
//
//  Created by coco on 16/6/1.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJRingView.h"

@interface HJRingView ()
/**shapeLayer*/
@property (nonatomic, strong)CAShapeLayer *progressLayer;
/**trackLayer*/
@property (nonatomic, strong)CAShapeLayer *trackLayer;
@end
@implementation HJRingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup {
    self.trackLayer = [CAShapeLayer layer];
    [self.layer addSublayer:self.trackLayer];
    
    self.progressLayer = [CAShapeLayer layer];
    _progressLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:self.progressLayer];
    
    self.progressTintColor = [UIColor orangeColor];
    self.trackTintColor = [UIColor grayColor];
    self.progress = 0;
    self.progressWidth = 5;
}

- (void)setTrack
{
    NSLog(@"%@", NSStringFromCGPoint(CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)));
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2) radius:(self.bounds.size.width - _progressWidth)/ 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];;
    self.trackLayer.path = path.CGPath;
}

- (void)setProgress
{
    UIBezierPath *path  = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2) radius:(self.bounds.size.width - _progressWidth)/ 2 startAngle:- M_PI_2 endAngle:(M_PI * 2) * _progress - M_PI_2 clockwise:YES];
    _progressLayer.path = path.CGPath;
}

- (void)setProgressWidth:(CGFloat)progressWidth {
    _progressWidth = progressWidth;
    self.trackLayer.lineWidth = progressWidth;
    self.progressLayer.lineWidth = progressWidth;
    
    [self setProgress];
    [self setTrack];
}
- (void)setTrackTintColor:(UIColor *)trackTintColor {
    _trackTintColor = trackTintColor;
    self.trackLayer.strokeColor = trackTintColor.CGColor;
}
- (void)setProgressTintColor:(UIColor *)progressTintColor {
    _progressTintColor = progressTintColor;
    self.progressLayer.strokeColor = progressTintColor.CGColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.progressLayer.frame = self.bounds;
    self.trackLayer.frame = self.bounds;
}
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    [self setProgress];
}
@end
