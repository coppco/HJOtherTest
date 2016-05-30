//
//  HJAspectFitController.m
//  HJMasonryTest
//
//  Created by coco on 16/3/28.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJAspectFitController.h"

@interface HJAspectFitController ()

@end

@implementation HJAspectFitController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubView];
}
- (void)initSubView {
    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor redColor];
    UIView *blueView = [UIView new];
    blueView.backgroundColor = [UIColor blueColor];
    
    UIView *blackView = [UIView new];
    blackView.backgroundColor = [UIColor blackColor];
    UIView *whiteView = [UIView new];
    whiteView.backgroundColor = [UIColor whiteColor];
    
    [redView addSubview:blueView];
    [self.view addSubview:redView];
    [blackView addSubview:whiteView];
    [self.view addSubview:blackView];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(0);
        make.height.mas_equalTo(blackView);
    }];
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(redView);
        
        make.center.mas_equalTo(redView);
        //width = height / 3;  multipliedBy只能是同一个控件的属性
        make.width.mas_equalTo(blueView.mas_height).multipliedBy(6);
        
//        // 设置优先级
//        make.width.height.mas_equalTo(redView).priorityLow();
//        make.width.height.lessThanOrEqualTo(redView);
    }];
    
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(redView.mas_bottom);
        make.right.left.bottom.mas_equalTo(0);
    }];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(blackView);
        make.center.mas_equalTo(blackView);
        // 注意，这个multipliedBy的使用只能是设置同一个控件的，比如这里的bottomInnerView，
        // 设置高/宽为3:1
        make.height.mas_equalTo(whiteView.mas_width).multipliedBy(3);
        
        make.width.height.mas_equalTo(blackView).priorityLow();
        make.width.height.lessThanOrEqualTo(blackView);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
