//
//  WhatKeyboard.h
//  SecurityKeyboard
//
//  Created by apple on 2017/8/25.
//  Copyright © 2017年 my. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WhatKeyboard;
@protocol WhatKeyboardDelegate <NSObject>

@optional
/*清空输入框*/
- (void)clearText:(WhatKeyboard *)keyboard;
/*点击空格*/
- (void)didClickSpace:(WhatKeyboard *)keyboard;
/*点击删除*/
- (void)didClickDelete:(WhatKeyboard *)keyboard;
/*点击确定*/
- (void)didClickConfirm:(WhatKeyboard *)keyboard;
/*点击字符*/
- (void)didClickCharacter:(WhatKeyboard *)keyboard withString:(NSString *)str;
@end

@interface WhatKeyboard : UIView
/**
 * 创建键盘
 */
+ (instancetype)keyboard;
/*
 * 恢复默认样子
 */
- (void)resetDefault;
/**
 * 代理
 */
@property (nonatomic, weak) id<WhatKeyboardDelegate> delegate;
@end
