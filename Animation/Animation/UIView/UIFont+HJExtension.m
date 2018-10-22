//
//  UIFont+HJExtension.m
//  Animation
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UIFont+HJExtension.h"
#import <objc/runtime.h>

@implementation UIFont (HJExtension)
+ (void)load {
    // 生成Method
    Method originMethod = class_getClassMethod([UIFont class], @selector(fontWithName:size:));
    Method newMethod = class_getClassMethod([UIFont class], @selector(hj_fontWithName:size:));
    //交换方法
    method_exchangeImplementations(originMethod, newMethod);
}
+ (nullable UIFont *)hj_fontWithName:(NSString *)fontName size:(CGFloat)fontSize {
    if (([[UIDevice currentDevice].systemVersion floatValue]) <= 9.0) {
       fontName = @"HiraKakuProN-W3";
    }
    return [self hj_fontWithName:fontName size:fontSize];
}
@end
