//
//  HJTextView.m
//  11-带文字的slider
//
//  Created by coco on 16/5/31.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJTextView.h"

@interface HJTextView ()
/**文本*/
@property (nonatomic, strong)UILabel *textLabel;
@end

@implementation HJTextView

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
    self.textLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont boldSystemFontOfSize:13];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.adjustsFontSizeToFitWidth = YES;
        label.textColor = [UIColor redColor];
        label;
    });
    [self addSubview:self.textLabel];
    self.opaque = NO;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = self.bounds;
}
- (void)setText:(NSString *)text {
    _text = text;
    self.textLabel.text = text;
}
- (void)drawRect:(CGRect)rect
{
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    UIColor* gradientColor = [UIColor cyanColor];
    UIColor* gradientColor2 = [UIColor orangeColor];
    
    NSArray* gradientColors = [NSArray arrayWithObjects:
                               (id)gradientColor.CGColor,
                               (id)gradientColor2.CGColor, nil];
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    
    CGRect frame = self.bounds;
    
    
    CGRect frame2 = CGRectMake(CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 11) * 0.51724 + 0.5), CGRectGetMinY(frame) + CGRectGetHeight(frame) - 9, 11, 9);
    
    //绘制贝塞尔曲线
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(CGRectGetMaxX(frame) - 0.5, CGRectGetMinY(frame) + 4.5)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMaxX(frame) - 0.5, CGRectGetMaxY(frame) - 11.5)];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMaxX(frame) - 4.5, CGRectGetMaxY(frame) - 7.5) controlPoint1: CGPointMake(CGRectGetMaxX(frame) - 0.5, CGRectGetMaxY(frame) - 9.29) controlPoint2: CGPointMake(CGRectGetMaxX(frame) - 2.29, CGRectGetMaxY(frame) - 7.5)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame2) + 10.64, CGRectGetMinY(frame2) + 1.5)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame2) + 5.5, CGRectGetMinY(frame2) + 8)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame2) + 0.36, CGRectGetMinY(frame2) + 1.5)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 4.5, CGRectGetMaxY(frame) - 7.5)];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.5, CGRectGetMaxY(frame) - 11.5) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 2.29, CGRectGetMaxY(frame) - 7.5) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.5, CGRectGetMaxY(frame) - 9.29)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.5, CGRectGetMinY(frame) + 4.5)];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 4.5, CGRectGetMinY(frame) + 0.5) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.5, CGRectGetMinY(frame) + 2.29) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 2.29, CGRectGetMinY(frame) + 0.5)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMaxX(frame) - 4.5, CGRectGetMinY(frame) + 0.5)];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMaxX(frame) - 0.5, CGRectGetMinY(frame) + 4.5) controlPoint1: CGPointMake(CGRectGetMaxX(frame) - 2.29, CGRectGetMinY(frame) + 0.5) controlPoint2: CGPointMake(CGRectGetMaxX(frame) - 0.5, CGRectGetMinY(frame) + 2.29)];
    [bezierPath closePath];
    CGContextSaveGState(context);
    [bezierPath addClip];
    CGRect bezierBounds = bezierPath.bounds;
    CGContextDrawLinearGradient(context, gradient,
                                CGPointMake(CGRectGetMidX(bezierBounds), CGRectGetMinY(bezierBounds)),
                                CGPointMake(CGRectGetMidX(bezierBounds), CGRectGetMaxY(bezierBounds)),
                                0);
    CGContextRestoreGState(context);
    
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

@end
