//
//  HJCompositeController.m
//  HJMasonryTest
//
//  Created by coco on 16/3/28.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJCompositeController.h"

@interface HJCompositeController ()
@property (nonatomic, assign)BOOL isNormal;
@property (nonatomic, strong)NSMutableArray *viewArray;
@end

@implementation HJCompositeController
- (NSMutableArray *)viewArray {
    if (_viewArray == nil) {
        _viewArray = [NSMutableArray array];
    }
    return _viewArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *lastView = self.view;
    for (int i = 0; i < 7; i++) {
        UIView *view = [UIView new];
        view.backgroundColor = [self randomColor];
        [self.view addSubview:view];
        [self.viewArray addObject:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(lastView).insets(UIEdgeInsetsMake(20, 20, 20, 20));
        }];
        lastView = view;
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
    
      self.isNormal = YES;
}
- (UIColor *)randomColor {
    CGFloat red = arc4random() % 256 / 255.0;
    CGFloat green = arc4random() % 256 / 255.0;
    CGFloat blue = arc4random() % 256 / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}
- (void)tap:(UITapGestureRecognizer *)tap {
    UIView *lastView = self.view;
    
    if (self.isNormal) {
        for (NSInteger i = self.viewArray.count - 1; i >= 0; i--) {
            UIView *itemView = [self.viewArray objectAtIndex:i];
            [itemView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(lastView).insets(UIEdgeInsetsMake(20, 20, 20, 20));
            }];
            
            [self.view bringSubviewToFront:itemView];
            lastView = itemView;
            
        }
    } else {
        for (NSInteger i = 0; i < self.viewArray.count; ++i) {
            UIView *itemView = [self.viewArray objectAtIndex:i];
            [itemView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(lastView).insets(UIEdgeInsetsMake(20, 20, 20, 20));
            }];
            
            [self.view bringSubviewToFront:itemView];
            lastView = itemView;
        }
    }
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.isNormal = !self.isNormal;
    }];
}
@end
