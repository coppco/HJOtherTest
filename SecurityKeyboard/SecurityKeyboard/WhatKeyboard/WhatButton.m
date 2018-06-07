//
//  WhatButton.m
//  SecurityKeyboard
//
//  Created by apple on 2017/8/25.
//  Copyright © 2017年 my. All rights reserved.
//

#import "WhatButton.h"
#import "UIImage+ColorExtension.h"

#define kLineWidth 0.5
@implementation WhatButton
- (void)dealloc {
    NSLog(@"%@释放了", self.class);
}
+ (void)load {
    WhatButton *appearance = [WhatButton appearance];

    appearance.titleLabel.font = [UIFont boldSystemFontOfSize:40];

    [appearance setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithRed:231 / 256.0  green:231 / 256.0 blue:231 / 256.0 alpha:1]] forState:(UIControlStateHighlighted)];
}
- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    if (self.isShowLeft) {
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(0, rect.size.height)];
    }
    
    if (self.isShowRight) {
        [path moveToPoint:CGPointMake(rect.size.width, 0)];
        [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
    }
    
    CGContextSetStrokeColorWithColor(ctx, [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor);
    CGContextSetLineWidth(ctx, kLineWidth);
    
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
}



@end
