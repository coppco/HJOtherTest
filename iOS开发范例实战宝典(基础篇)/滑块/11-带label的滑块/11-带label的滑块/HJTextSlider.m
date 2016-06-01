//
//  HJTextSlider.m
//  11-带label的滑块
//
//  Created by coco on 16/6/1.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJTextSlider.h"
#import "HJPopView.h"
@interface HJTextSlider ()
/**显示文本*/
@property (nonatomic, strong)HJPopView *popView;
@end
@implementation HJTextSlider
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
    self.popView = ({
        HJPopView *hjName = [[HJPopView alloc] init];
        hjName.alpha = 0;
        hjName;
    });
    //默认值
    self.minimumValue = 0;
    self.value = 0;
    self.maximumValue = 1;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self showPopTextViewAnimation:YES];
    [super touchesBegan:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hidePopTextViewAnimation:YES];
    [self touchesCancelled:touches withEvent:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hidePopTextViewAnimation:YES];
    [super touchesEnded:touches withEvent:event];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self popViewCurrentFrame];
}
//更新popView的frame
- (void)popViewCurrentFrame {
    CGFloat width = 40;
    CGFloat height = 32;
    CGFloat y = self.frame.origin.y - height - 3;
    
    CGFloat minimum = self.minimumValue;
    CGFloat maximum = self.maximumValue;
    CGFloat value = self.value;
    if (minimum < 0) {
        value = value - minimum;
        maximum = maximum - minimum;
        minimum = 0;
    }
    
    CGFloat x = self.frame.origin.x;
    CGFloat maxMin = (maximum + minimum) / 2.0;
    x += (((value - minimum) / (maximum - minimum)) * self.frame.size.width) - (self.popView.frame.size.width / 2.0);
    //当前的值与中间值的判断,修正位置
    if (value > maxMin) {
        value = (value - maxMin) + (minimum * 1.0);
        value = value / maxMin;
        value = value * 16.5;
        x = x - value;
    } else {
        value = (maxMin - value) + (minimum * 1.0);
        value = value / maxMin;
        value = value * 16.5;
        x = x + value;
    }

    self.popView.frame = CGRectMake(x, y, width, height);
    self.popView.text = [NSString stringWithFormat:@"%.2f", round(self.value * 100) / 100];
}
//当本身添加到父控件的时候,把文本也添加进去
- (void)didMoveToSuperview {
    [self.superview addSubview:self.popView];
}
#pragma - mark 显示隐藏文本
- (void)showPopTextView {
    [self showPopTextViewAnimation:NO];
}
- (void)hidePopTextView {
    [self hidePopTextViewAnimation:NO];
}
- (void)showPopTextViewAnimation:(BOOL)animation {
    if (animation) {
        [UIView animateWithDuration:0.25 animations:^{
            self.popView.alpha = 1;
        }];
    } else {
        self.popView.alpha = 1;
    }
}
- (void)hidePopTextViewAnimation:(BOOL)animation {
    if (animation) {
        [UIView animateWithDuration:0.25 animations:^{
            self.popView.alpha = 0;
        }];
    } else {
        self.popView.alpha = 0;
    }
}

@end
