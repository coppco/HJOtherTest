//
//  HJUnderLineButton.m
//  03-带下划线的按钮
//
//  Created by M-coppco on 16/5/28.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

#import "HJUnderLineButton.h"

@implementation HJUnderLineButton

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    self.underLineColor = [UIColor redColor];
    
    self.highlight = YES;
}
- (void)drawRect:(CGRect)rect {
    CGRect frame = self.titleLabel.frame;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, frame.origin.x, frame.origin.y + frame.size.height + 3);
    CGContextAddLineToPoint(context, frame.origin.x + frame.size.width, frame.origin.y + frame.size.height + 3);
    CGContextSetLineWidth(context, 3);
    if (!self.underLineColor) {
        self.underLineColor = [UIColor grayColor];
    }
    CGContextSetStrokeColorWithColor(context, self.underLineColor.CGColor);
//    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke);
}
- (void)setUnderLineColor:(UIColor *)underLineColor {
    _underLineColor = underLineColor;
    [self setNeedsDisplay];
}
@end
