//
//  HJTableViewController.m
//  HJMasonryTest
//
//  Created by coco on 16/3/28.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJTableViewController.h"
#import "HJTestCell.h"


@interface HJTableViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@end

@implementation HJTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initTableView];
}
- (void)initTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}
- (void)initData {
    for (NSUInteger i = 0; i < 10; ++i) {
        HJTestModel *model = [[HJTestModel alloc] init];
        model.title = @"测试标题，可能很长很长，反正随便写着先吧！";
        model.desc = @"描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，描述内容通常都是很长很长的，";
        
        [self.dataSource addObject:model];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma - mark getter方法
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
#pragma - mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HJTestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[HJTestCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    cell.model = self.dataSource[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}
@end
