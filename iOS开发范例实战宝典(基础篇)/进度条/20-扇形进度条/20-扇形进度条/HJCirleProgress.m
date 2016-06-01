//
//  HJCirleProgress.m
//  20-扇形进度条
//
//  Created by coco on 16/6/1.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJCirleProgress.h"

@implementation HJCirleProgress

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
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(update:) userInfo:nil repeats:YES];
}
static int i = 0;
- (void)update:(NSTimer *)tomer {
    self.progress = ((i++ >100) ? (i = 0) : i) / 100.0;
    NSLog(@"%f", self.progress);
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    
    [self fillCircleWithRect:rect margin:0 color:[UIColor redColor] progress:1];
    
    [self fillCircleWithRect:rect margin:5 color:[UIColor purpleColor] progress:1];
    
    [self fillCircleWithRect:rect margin:5 color:[UIColor greenColor] progress:self.progress];
    
}

- (void)fillCircleWithRect:(CGRect)rect margin:(CGFloat)margin color:(UIColor *)color  progress:(CGFloat)progress{
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGFloat radius = MIN(rect.size.width / 2, rect.size.height / 2) - margin;
    CGPoint circle = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    //画大圆
    CGContextMoveToPoint(context, circle.x, circle.y);
    CGContextAddArc(context, circle.x, circle.y, radius, (CGFloat) -M_PI_2, (CGFloat) (-M_PI_2 + M_PI * 2 * progress), NO);
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextFillPath(context);  //填充
}
@end
