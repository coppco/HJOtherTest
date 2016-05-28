//
//  HJShinyButton.m
//  04-抛光效果的按钮
//
//  Created by M-coppco on 16/5/28.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

#import "HJShinyButton.h"

@implementation HJShinyButton
- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
//        [self configWith:self.backgroundColor];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
//        [self configWith:self.backgroundColor];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame withBackgroundColor:(UIColor*)backgroundColor {
    self = [super initWithFrame:frame];
    if (self) {
//        [self addTarget:self action:@selector(wasPressed) forControlEvents:UIControlEventTouchDown];
//        [self addTarget:self action:@selector(endedPress) forControlEvents:UIControlEventTouchUpInside];
//        [self configWith:backgroundColor];
    }
    return self;
}
- (void)configWith:(UIColor *)bg {
    CALayer *layer = self.layer;
    layer.cornerRadius = 8.0f;
    layer.masksToBounds = YES;
    layer.borderWidth = 2.0f;
    layer.borderColor = [UIColor colorWithWhite:0.4f alpha:0.2f].CGColor;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = self.layer.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                       (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                       (id)[UIColor colorWithWhite:0.75f alpha:0.2f].CGColor,
                       (id)[UIColor colorWithWhite:0.4f alpha:0.2f].CGColor,
                       (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                       nil];
    
    gradient.locations = [NSArray arrayWithObjects:
                            [NSNumber numberWithFloat:0.0f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.8f],
                            [NSNumber numberWithFloat:1.0f],
                            nil];
    
    
    [self.layer addSublayer:gradient];
    self.backgroundColor = bg;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    //下面这个方法如果没有frame的时候会有bug:在init方法中的话背景色不全
    [self configWith:self.backgroundColor];
}
@end
