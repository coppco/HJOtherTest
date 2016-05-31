//
//  HJTextSlider.m
//  11-带文字的slider
//
//  Created by coco on 16/5/31.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJTextSlider.h"
#import "HJTextView.h"
@interface HJTextSlider ()
/**显示文本的视图*/
@property (nonatomic, strong)HJTextView *textView;
@end

@implementation HJTextSlider

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configSubView];
    }
    return self;
}
- (void)configSubView {
    self.textView = ({
        HJTextView *hjName = [[HJTextView alloc] init];
        hjName.text = @"1111";
        hjName.bounds = CGRectMake(0, 0, 40, 32);
        hjName;
    });
    self.minimumValue = 0.0f;
    self.maximumValue = 1.0f;
    [self addTarget:self action:@selector(slider:) forControlEvents:(UIControlEventValueChanged)];
}
- (void)slider:(HJTextSlider *)slider {
    [self updateTextViewFrame];
    self.textView.text = [NSString stringWithFormat:@"%.2f", self.value];
    if (self.sliderHasSlide) {
        self.sliderHasSlide(slider);
    }
}
//当本身添加到父视图的时候,文本也添加进去
- (void)didMoveToSuperview {
    [self.superview addSubview:self.textView];
}
- (void)updateTextViewFrame {
    CGFloat minimum =  self.minimumValue;
    CGFloat maximum = self.maximumValue;
    CGFloat value = self.value;
    if (minimum < 0.0) {
        
        value = self.value - minimum;
        maximum = maximum - minimum;
        minimum = 0.0;
    }
    CGFloat x = self.frame.origin.x;
    CGFloat maxMin = (maximum + minimum) / 2.0;
    x += (((value - minimum) / (maximum - minimum)) * self.frame.size.width) - (self.textView.frame.size.width / 2.0);
    //当前的值与中间值的判断
    if (value > maxMin) {
        
        value = (value - maxMin) + (minimum * 1.0);
        value = value / maxMin;
        value = value * 11.0;
        x = x - value;
    } else {
        value = (maxMin - value) + (minimum * 1.0);
        value = value / maxMin;
        value = value * 11.0;
        
        x = x + value;
    }
    CGRect popoverRect = self.textView.frame;
    popoverRect.origin.x = x;
    popoverRect.origin.y = self.frame.origin.y - popoverRect.size.height - 1;
    self.textView.frame = popoverRect;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self showPopoverAnimation:YES];
    [self updateTextViewFrame];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hidePopoverAnimation:YES];
    [super touchesCancelled:touches withEvent:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hidePopoverAnimation:YES];
    [super touchesEnded:touches withEvent:event];
}
#pragma - mark 显示或者隐藏方法
- (void)showPopover {
    [self showPopoverAnimation:NO];
}
- (void)showPopoverAnimation:(BOOL)animation {
    if (animation) {
        [UIView animateWithDuration:0.25 animations:^{
            self.textView.alpha = 1;
        }];
    } else {
        self.textView.alpha = 1;
    }
}
- (void)hidePopover {
    [self hidePopoverAnimation:NO];
}
- (void)hidePopoverAnimation:(BOOL)animation {
    if (animation) {
        [UIView animateWithDuration:0.25 animations:^{
            self.textView.alpha = 0;
        }];
    } else {
        self.textView.alpha = 0;
    }
}


@end
