//
//  UINavigationController+HJExtension.h
//  Podinns
//
//  Created by apple on 2017/3/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (HJExtension)

/**
 在导航栏下方显示消息

 @param text 消息
 */
- (void)showText:(NSString *)text;
@end
