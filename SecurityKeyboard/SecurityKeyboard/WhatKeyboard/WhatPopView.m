//
//  WhatPopView.m
//  SecurityKeyboard
//
//  Created by apple on 2017/8/25.
//  Copyright © 2017年 my. All rights reserved.
//

#import "WhatPopView.h"

@interface WhatPopView ()
/*标题*/
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation WhatPopView

+ (instancetype)popView {
    WhatPopView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
//    view.transform = CGAffineTransformMakeScale(1.03, 1.03);
    return view;
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return false;
}

- (void)showFromButton:(UIButton *)button {
    NSString * title = button.currentTitle;
    if (button == nil || !(title.length > 0)) {
        return;
    }
    
    self.titleL.text = title;
    
    CGRect btnFrame = [button convertRect:button.bounds toView:nil];

    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    self.center = CGPointMake(MAX(MIN(CGRectGetMidX(btnFrame), [UIScreen mainScreen].bounds.size.width - self.frame.size.width / 2), self.frame.size.width / 2), CGRectGetMinY(btnFrame) - self.frame.size.height / 2);
    [window addSubview:self];
}
@end
