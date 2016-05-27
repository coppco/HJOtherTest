//
//  GreenView.m
//  XHJ-autoLayout练习
//
//  Created by coco on 16/3/25.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "GreenView.h"

@interface GreenView ()
@property (weak, nonatomic) IBOutlet UIView *colorView;

@property (weak, nonatomic) IBOutlet UIButton *btn;
@end

@implementation GreenView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    NSLog(@"%@", [touch.view class]);
}
//查找并返回最适合处理event的view, 返回nil则由父控件处理
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint btnP = [self convertPoint:point toView:_btn];
    
    if ([_btn pointInside:btnP withEvent:event]) {
        return _btn;
    }
    return [super hitTest:point withEvent:event];
}
//判断touch点是不是在这个view,在返回yes
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return YES;
}
@end
