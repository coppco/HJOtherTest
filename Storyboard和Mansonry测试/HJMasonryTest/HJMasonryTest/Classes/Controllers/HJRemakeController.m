//
//  HJRemakeController.m
//  HJMasonryTest
//
//  Created by coco on 16/3/28.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJRemakeController.h"

@interface HJRemakeController ()
@property (nonatomic, strong)UIButton *button;
@end

@implementation HJRemakeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.button.layer.borderColor = [UIColor redColor].CGColor;
    self.button.layer.borderWidth = 2.0f;
    [self.button addTarget:self action:@selector(button:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.button setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
    [self.button setTitle:@"点击展开" forState:(UIControlStateNormal)];
     [self.button setTitle:@"点击收起" forState:(UIControlStateSelected)];
    [self.view addSubview:self.button];
    
    //设置一下或者手动调用一次button方法 或者
//    [self button:nil];

    
    [self.button mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-self.view.frame.size.height * 0.8);
    }];
}
- (void)button:(UIButton *)button {
    button.selected = !button.selected;
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (void)updateViewConstraints {
    // 这里使用update也是一样的。
    // remake会将之前的全部移除，然后重新添加
    [self.button mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        if (self.button.selected) {
            make.bottom.mas_equalTo(-20);
        } else {
            make.bottom.mas_equalTo(-self.view.frame.size.height * 0.8);
        }
    }];
    [super updateViewConstraints];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
@end
