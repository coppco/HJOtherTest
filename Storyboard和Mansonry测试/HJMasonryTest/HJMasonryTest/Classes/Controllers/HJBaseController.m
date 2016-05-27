//
//  HJBaseController.m
//  HJMasonryTest
//
//  Created by coco on 16/3/28.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJBaseController.h"

@interface HJBaseController ()

@end

@implementation HJBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *greenL = [HJTool allocLabelWithFrame:CGRectZero title:@"" textColor:nil backgroundColor:[UIColor greenColor]];
    [self.view addSubview:greenL];
    
    UILabel *blueL = [HJTool allocLabelWithFrame:CGRectZero title:@"" textColor:nil backgroundColor:[UIColor blueColor]];
    [self.view addSubview:blueL];
    
    UILabel *redL = [HJTool allocLabelWithFrame:CGRectZero title:@"" textColor:nil backgroundColor:[UIColor redColor]];
    [self.view addSubview:redL];
    
    _padding = 10;
    [greenL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.view).offset(_padding);
        make.size.mas_equalTo(blueL);
        make.right.mas_equalTo(blueL.mas_left).offset(-_padding);
        make.bottom.mas_equalTo(redL.mas_top).offset(-_padding);
        greenL.text = @"这里绿色的label, 设置left top和self.view边距为10, right和蓝色的mas_left距离10, bottom和红色的view的mas_top相距为10, size和蓝色的label相同";
    }];
    [blueL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(_padding);
        make.right.mas_equalTo(self.view).offset(-_padding);
        blueL.text = @"top和right相距view为10";
    }];
    
    [redL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(greenL);
        make.left.mas_equalTo(_padding);
        make.right.bottom.mas_equalTo(-_padding);
        redL.text = @"这里设置红色label的height 和 绿色的高一样, left right bottom 距离self.view为10";
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
