//
//  UIViewController+PlaceholderView.m
//  HJPlaceholderView
//
//  Created by apple on 2017/5/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UIViewController+PlaceholderView.h"
#import <objc/runtime.h>
@implementation UIViewController (PlaceholderView)
- (HJPlaceholderView *)placeholderView {
    HJPlaceholderView *view = objc_getAssociatedObject(self, @selector(placeholderView));
    if (view == nil) {
        view = [HJPlaceholderView placeholderViewForView:self.view];
        self.placeholderView = view;
    }
    return view;
}

- (void)setPlaceholderView:(HJPlaceholderView *)placeholderView {
    if (placeholderView == nil) {
        return;
    }
    objc_setAssociatedObject(self, @selector(placeholderView), placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
