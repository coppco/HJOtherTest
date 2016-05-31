//
//  HJTextSlider.h
//  11-带文字的slider
//
//  Created by coco on 16/5/31.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJTextSlider : UISlider
/**改变文本frame和监听slider滑动block*/
@property (nonatomic, copy)void (^sliderHasSlide) (HJTextSlider *slider);

- (void)showPopover;
- (void)showPopoverAnimation:(BOOL)animation;

- (void)hidePopover;
- (void)hidePopoverAnimation:(BOOL)animation;
@end
