//
//  ViewController.m
//  HJNavigationAnimation
//
//  Created by coco on 16/6/23.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
/**tableView*/
@property (nonatomic, strong)UITableView *tableView;
/**图像*/
@property (nonatomic, strong)UIImageView *imageV;
@end

@implementation ViewController
- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, -250, self.view.frame.size.width, 250)];
        _imageV.contentMode = UIViewContentModeScaleAspectFit;
        _imageV.image = [UIImage imageNamed:@"城市"];
//        _imageV.backgroundColor = [UIColor redColor];
    }
    return _imageV;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = ({
            UITableView *object = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
            object.delegate = self;
            object.dataSource = self;
            object.contentInset = UIEdgeInsetsMake(250, 0, 0, 0);
            object;
        });
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configSubview];
}
- (void)configSubview {
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.imageV];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.mas_equalTo(250);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = indexPath.description;
    return cell;
}


@end
