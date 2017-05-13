//
//  UIBarButtonItem+HJExtension.m
//  Podinns
//
//  Created by apple on 2017/3/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UIBarButtonItem+HJExtension.h"

@implementation UIBarButtonItem (HJExtension)

+ (instancetype)barButtonItemWithTitle:(NSString *)title titleNormalColor:(UIColor *)normalColor titleHighlightedColor:(UIColor *)highlightedColor normalImage:(NSString *)normalImage highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action edg:(UIEdgeInsets)edg {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    button.frame = CGRectMake(0, 0, 50, 32);
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateHighlighted];
    }
    if (normalColor) {
        [button setTitleColor:normalColor forState:(UIControlStateNormal)];
    }
    if (highlightedColor) {
        [button setTitleColor:highlightedColor forState:(UIControlStateHighlighted)];
    }
    
    
    if (normalImage) {
        [button setImage:[UIImage imageNamed:normalImage] forState:(UIControlStateNormal)];
    }
    if (highlightedImage) {
        [button setImage:[UIImage imageNamed:highlightedImage] forState:(UIControlStateHighlighted)];
    }
    if (target && action) {
        [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    }
    [button sizeToFit];
    
    button.contentEdgeInsets = edg;
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
