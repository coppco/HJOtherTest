//
//  HJDDD.m
//  HJNavigationAnimation
//
//  Created by coco on 16/6/23.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJDDD.h"

@implementation HJDDD

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.ddd = [[UITextField alloc] init];
        [self addSubview:self.ddd];
//        self.ddd.backgroundColor = [UIColor redColor];
//        self.backgroundColor = [UIColor greenColor];
        self.ddd.userInteractionEnabled = NO;
        self.secureTextEntry = YES;
        self.alpha = 0.02;
        self.ddd.alpha = 1;
        [self sendSubviewToBack:self.ddd];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.ddd.frame = self.bounds;
}
- (void)setText:(NSString *)text {
    self.ddd.text = text;
}
@end
