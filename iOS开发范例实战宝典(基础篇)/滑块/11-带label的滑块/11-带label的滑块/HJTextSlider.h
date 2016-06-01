//
//  HJTextSlider.h
//  11-带label的滑块
//
//  Created by coco on 16/6/1.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJTextSlider : UISlider

- (void)showPopTextView;
- (void)showPopTextViewAnimation:(BOOL)animation;
- (void)hidePopTextView;
- (void)hidePopTextViewAnimation:(BOOL)animation;

@end
