//
//  HJCircleSlider.m
//  08-环形滑块
//
//  Created by coco on 16/5/31.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJCircleSlider.h"
#define kHJLineWidth 5.0
#define kHJThumbRadius 12.0
@implementation HJCircleSlider
//传入一个(0--1)的值相对于最大值,把它转成(0--2π)的弧度
float translateValueFromSourceIntervalToDestinationInterval(float sourceValue, float sourceIntervalMinimum, float sourceIntervalMaximum, float destinationIntervalMinimum, float destinationIntervalMaximum) {
    float a, b, destinationValue;
    
    a = (destinationIntervalMaximum - destinationIntervalMinimum) / (sourceIntervalMaximum - sourceIntervalMinimum);
    b = destinationIntervalMaximum - a*sourceIntervalMaximum;
    
    destinationValue = a*sourceValue + b;
    
    return destinationValue;
}

CGFloat angleBetweenThreePoints(CGPoint centerPoint, CGPoint p1, CGPoint p2) {
    CGPoint v1 = CGPointMake(p1.x - centerPoint.x, p1.y - centerPoint.y);
    CGPoint v2 = CGPointMake(p2.x - centerPoint.x, p2.y - centerPoint.y);
    
    CGFloat angle = atan2f(v2.x*v1.y - v1.x*v2.y, v1.x*v2.x + v1.y*v2.y);
    
    return angle;
    
}

- (void)setup {
    self.value = 0.0f;
    self.minimumValue = 0.0f;
    self.maximumValue = 1.0f;
    
    self.minimumTrackTintColor  = [UIColor blueColor];
    self.maximumTrackTintColor = [UIColor greenColor];
    self.thumbTintColor = [UIColor purpleColor];
    
    self.backgroundColor = [UIColor clearColor];
    
    //手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    pan.maximumNumberOfTouches = pan.minimumNumberOfTouches;
    [self addGestureRecognizer:pan];
}
/*平移方法*/
- (void)panGesture:(UIPanGestureRecognizer *)pan {
    CGPoint tapLocation = [pan locationInView:self];
    UIGestureRecognizerState state = pan.state;
    switch (state) {
        case UIGestureRecognizerStateChanged: {
            CGFloat radius = [self sliderRadius];
            CGPoint sliderCenter = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
            CGPoint sliderStartPoint = CGPointMake(sliderCenter.x, sliderCenter.y - radius);
            CGFloat angle = angleBetweenThreePoints(sliderCenter, sliderStartPoint, tapLocation);
            
            if (angle < 0) {
                angle = -angle;
            }
            else {
                angle = 2*M_PI - angle;
            }
            
            self.value = translateValueFromSourceIntervalToDestinationInterval(angle, 0, 2*M_PI, self.minimumValue, self.maximumValue);
            break;
        }
        default:
            break;
    }
    
    
}
- (instancetype)initWithFrame:(CGRect)frame {
    self  = [super initWithFrame:frame];
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
/*获取半径*/
- (CGFloat)sliderRadius {
    CGFloat radius = MIN(self.bounds.size.width / 2, self.bounds.size.height / 2);
    radius -= MAX(kHJLineWidth, kHJThumbRadius);
    return radius;
}
- (void)drawRect:(CGRect)rect {
    //上下文
    CGContextRef context  = UIGraphicsGetCurrentContext();
    
    //线宽
    CGContextSetLineWidth(context, kHJLineWidth);
    
    //圆点
    CGPoint middlePoint;
    middlePoint.x = self.bounds.origin.x + self.bounds.size.width/2;
    middlePoint.y = self.bounds.origin.y + self.bounds.size.height/2;
    
    //半径
    CGFloat radius = [self sliderRadius];
    
    //画圆环
    
    //大圆环
    [self.maximumTrackTintColor setStroke]; //颜色
    [self drawCircleWithRadius:radius point:middlePoint context:context trackValue:self.maximumValue];
    
    //小圆环
    [self.minimumTrackTintColor setStroke];
    CGPoint endPoint = [self drawCircleWithRadius:radius point:middlePoint context:context trackValue:self.value];
    
    //画当前值拇指
    [self.thumbTintColor setFill];
    [self drawThumbAtPoint:endPoint inContext:context];
    
}
/*圆环*/
- (CGPoint)drawCircleWithRadius:(CGFloat)radius point:(CGPoint)center context:(CGContextRef)context trackValue:(CGFloat)trackValue{
    UIGraphicsPushContext(context);  //保存
    CGContextBeginPath(context);
    
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle = translateValueFromSourceIntervalToDestinationInterval(trackValue, self.minimumValue, self.maximumValue, 0, 2 * M_PI) + startAngle;
    
    CGContextAddArc(context, center.x, center.y, radius, startAngle, endAngle, NO);
    CGPoint arcEndPoint = CGContextGetPathCurrentPoint(context);
    
    CGContextStrokePath(context);
    UIGraphicsPopContext();
    
    return arcEndPoint;
}
//画大拇指点
- (void)drawThumbAtPoint:(CGPoint)point inContext:(CGContextRef)context{
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, point.x, point.y);
    CGContextAddArc(context, point.x, point.y, kHJThumbRadius, 0, 2 * M_PI, NO);
    CGContextFillPath(context);
    UIGraphicsPopContext();
}

#pragma - mark setter和getter方法
- (void)setValue:(CGFloat)value {
    if (value != _value) {
        if (value > self.maximumValue) { value = self.maximumValue; }
        if (value < self.minimumValue) { value = self.minimumValue; }
        _value = value;
        [self setNeedsDisplay];
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}
- (void)setMinimumValue:(CGFloat)minimumValue {
    if (minimumValue != _minimumValue) {
        _minimumValue = minimumValue;
        if (self.maximumValue < self.minimumValue)	{ self.maximumValue = self.minimumValue; }
        if (self.value < self.minimumValue)			{ self.value = self.minimumValue; }
    }
}
- (void)setMaximumValue:(CGFloat)maximumValue {
    if (maximumValue != _maximumValue) {
        _maximumValue = maximumValue;
        if (self.minimumValue > self.maximumValue)	{ self.minimumValue = self.maximumValue; }
        if (self.value > self.maximumValue)			{ self.value = self.maximumValue; }
    }
}
- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor {
    if (![minimumTrackTintColor isEqual:_minimumTrackTintColor]) {
        _minimumTrackTintColor = minimumTrackTintColor;
        [self setNeedsDisplay];
    }
}
- (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor {
    if (![maximumTrackTintColor isEqual:_maximumTrackTintColor]) {
        _maximumTrackTintColor = maximumTrackTintColor;
        [self setNeedsDisplay];
    }
}
- (void)setThumbTintColor:(UIColor *)thumbTintColor {
    if (![thumbTintColor isEqual:_thumbTintColor]) {
        _thumbTintColor = thumbTintColor;
        [self setNeedsDisplay];
    }
}
@end
