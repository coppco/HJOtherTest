//
//  TableViewController.m
//  UITableVlewDemo
//
//  Created by 陆巧怡 on 15/10/18.
//  Copyright © 2015年 Simon. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "TableViewModel.h"
@interface TableViewController ()
@property (nonatomic,strong) NSMutableArray *tableData; // 动态模型

@end

@implementation TableViewController


- (NSMutableArray *)tableData
{
    if (!_tableData) {
        _tableData = [NSMutableArray array];
    }
    return _tableData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadJSONData];
    
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];

    [self.tableView reloadData];
}

#pragma mark - 加载json数据
- (void)loadJSONData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"]; // 解析json
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *jsonArray = dict[@"feed"];
    
    NSMutableArray *muArray = [NSMutableArray array];
    
    [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [muArray addObject:[TableViewModel feedWithDictionary:obj]];
        
    }];
    self.tableData = muArray;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = self.tableData[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [self.tableView fd_heightForCellWithIdentifier:@"cell" cacheByIndexPath:indexPath configuration:^(TableViewCell *cell) {
        cell.model = self.tableData[indexPath.row];
    }];
        
}
@end
