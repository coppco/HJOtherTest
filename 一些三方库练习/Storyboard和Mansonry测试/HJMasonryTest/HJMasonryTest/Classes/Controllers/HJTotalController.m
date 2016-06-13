//
//  HJTotalController.m
//  HJMasonryTest
//
//  Created by coco on 16/3/28.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJTotalController.h"

@interface HJTotalController ()
@property (nonatomic, strong)UIView *redView;
@property (nonatomic, strong)UIView *blueView;
@property (nonatomic, assign)BOOL isExpanded;
@end

@implementation HJTotalController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubView];
}
- (void)initSubView {
    self.redView = [[UIView alloc] init];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.redView addGestureRecognizer:tap];
    
    self.blueView = [[UIView alloc] init];
    self.blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.blueView];
    
    // 这里，我们不使用updateViewConstraints方法，但是我们一样可以做到。
    // 不过苹果推荐在updateViewConstraints方法中更新或者添加约束的
    UILabel *label = [HJTool allocLabelWithFrame:CGRectZero title:@"点击红色部分可以控制放大和收起" textColor:[UIColor purpleColor] backgroundColor:nil];
    [self.redView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
    }];
}
#pragma - mark - tap手势
- (void)tap:(UITapGestureRecognizer *)tap {
    
    //更新约束可以写在updateViewConstraints,这是苹果推荐的方式,这里也可以不写在里面,使用另外的方法
    /*
        _isExpanded = !_isExpanded;
    // 告诉self.view约束需要更新
    [self.view setNeedsUpdateConstraints];
     // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.4 animations:^{
        [self.view layoutIfNeeded];
    }];
     */
    [self updateWithExpand:!self.isExpanded animated:YES];
}



- (void)updateWithExpand:(BOOL)isExpanded animated:(BOOL)animated {
    self.isExpanded = isExpanded;
    
    [self.redView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        if (_isExpanded) {
            make.bottom.mas_equalTo(-20);
        } else {
            make.bottom.mas_equalTo(-300);
        }
    }];
    
    [self.blueView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.redView);
        
        // 这里使用优先级处理
        // 设置其最大值为250，最小值为90
        if (!_isExpanded) {
            make.width.height.mas_equalTo(100 * 0.5).priorityLow();
        } else {
            make.width.height.mas_equalTo(100 * 3).priorityLow();
        }
        
        // 最大值为250
        make.width.height.lessThanOrEqualTo(@250);
        
        // 最小值为90
        make.width.height.greaterThanOrEqualTo(@90);
    }];
    
    if (animated) {
        [self.view setNeedsUpdateConstraints];
        [self.view updateConstraintsIfNeeded];
        
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

/*
- (void)updateViewConstraints {
    
    [self.redView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        if (_isExpanded) {
            make.bottom.mas_equalTo(-20);
        } else {
            make.bottom.mas_equalTo(-300);
        }
    }];
    
    [self.blueView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.redView);
        
        // 这里使用优先级处理
        // 设置其最大值为250，最小值为90
        if (!_isExpanded) {
            make.width.height.mas_equalTo(100 * 0.5).priorityLow();
        } else {
            make.width.height.mas_equalTo(100 * 3).priorityLow();
        }
        
        // 最大值为250
        make.width.height.lessThanOrEqualTo(@250);
        
        // 最小值为90
        make.width.height.greaterThanOrEqualTo(@90);
    }];
    [super updateViewConstraints];
}
 */
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
