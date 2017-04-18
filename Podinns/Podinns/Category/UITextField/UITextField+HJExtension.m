//
//  UITextField+HJExtension.m
//  Podinns
//
//  Created by apple on 2017/3/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UITextField+HJExtension.h"

@implementation UITextField (HJExtension)
- (UIColor *)placeHolderColor {
    return [self valueForKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor {
    if (self.placeholder) {
        [self setValue:placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
    } else {
        self.placeholder = @"";
        [self setValue:placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
        self.placeholder = nil;
    }
}
@end
