//
//  HJUpdateController.m
//  HJMasonryTest
//
//  Created by coco on 16/3/28.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJUpdateController.h"

@interface HJUpdateController ()
@property (nonatomic, assign)CGFloat scale;
@property (nonatomic, strong)UIButton *button;
@end

@implementation HJUpdateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scale = 1.0;
    [self addVerticalLabel];
    [self addHorizonalLabel];
    
    _button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _button.layer.borderColor = [UIColor greenColor].CGColor;
    [_button setTitle:@"点我吧" forState:(UIControlStateNormal)];
    [_button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    _button.layer.borderWidth = 2.0f;
    [_button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        // 初始宽、高为100，优先级最低
        make.width.height.mas_equalTo(100 * self.scale).priorityLow();
        // 最大放大到整个view
        make.width.height.lessThanOrEqualTo(self.view);
    }];
}
#pragma - mark 点击方法
- (void)buttonClick:(UIButton *)button {
    
    self.scale += 0.2;
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
     
//    [UIView animateWithDuration:0.3 animations:^{
//        [_button mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.center.mas_equalTo(self.view);
//            // 初始宽、高为100，优先级最低
//            make.width.height.mas_equalTo(100 * self.scale).priorityLow();
//            // 最大放大到整个view
//        }];
//    }];
}
- (void)updateViewConstraints {
    [_button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        // 初始宽、高为100，优先级最低
        make.width.height.mas_equalTo(100 * self.scale).priorityLow();
        // 最大放大到整个view
    }];
    [super updateViewConstraints];
}
#pragma - mark 添加垂直方法文本
- (void)addVerticalLabel {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        UILabel *label = [HJTool allocLabelWithFrame:CGRectZero title:[NSString stringWithFormat:@"第%d个", i] textColor:nil backgroundColor:[UIColor redColor]];
        [self.view addSubview:label];
        [array addObject:label];
    }
    /**
     * MASAxisType  表示数组中的控件在哪个方向上排列
     * length   控件在水平方向的width  或者在垂直方向上的height
     * lead  水平就是和父视图的left距离 垂直就是和父视图的top距离
     * tail 水平就是和父视图的right距离 垂直就是和父视图的bottom距离
     *  间隔自动计算
     */
//    [array mas_distributeViewsAlongAxis:(MASAxisTypeVertical) withFixedItemLength:100 leadSpacing:15 tailSpacing:30];
    
    /**
     * MASAxisType  表示数组中的控件在哪个方向上排列
     * Spacing   控件之间的间隔
     * lead  水平就是和父视图的left距离 垂直就是和父视图的top距离
     * tail 水平就是和父视图的right距离 垂直就是和父视图的bottom距离
     *  控件在水平方向的width  或者在垂直方向上的height 自动计算
     */
    [array mas_distributeViewsAlongAxis:(MASAxisTypeVertical) withFixedSpacing:10 leadSpacing:15 tailSpacing:30];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(50);
    }];
}
#pragma - mark 添加水平方向文本
- (void)addHorizonalLabel {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        UILabel *label = [HJTool allocLabelWithFrame:CGRectZero title:[NSString stringWithFormat:@"%d", i] textColor:nil backgroundColor:[UIColor blueColor]];
        [self.view addSubview:label];
        [array addObject:label];
    }
    /**
     * MASAxisType  表示数组中的控件在哪个方向上排列
     * length   控件在水平方向的width  或者在垂直方向上的height
     * lead  水平就是和父视图的left距离 垂直就是和父视图的top距离
     * tail 水平就是和父视图的right距离 垂直就是和父视图的bottom距离
     *  间隔自动计算
     */
    [array mas_distributeViewsAlongAxis:(MASAxisTypeHorizontal) withFixedItemLength:30 leadSpacing:100 tailSpacing:30];
    
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(50);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
