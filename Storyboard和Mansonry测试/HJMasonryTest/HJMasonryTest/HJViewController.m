//
//  ViewController.m
//  HJMasonryTest
//
//  Created by coco on 16/3/28.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJViewController.h"

@interface HJViewController ()
@property (nonatomic, strong)NSMutableArray *titles;
@property (nonatomic, strong)NSMutableArray *classNames;
@end

@implementation HJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    //去掉尾部多余的cell
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self addCell];
}
- (void)addCell {
    [self addTitle:@"Storyboard中scrollview布局" className:@"one"];
    [self addTitle:@"Storyboard平行布局" className:@"two"];
    [self addTitle:@"基本使用" className:@"HJBaseController"];
    [self addTitle:@"动画更新约束" className:@"HJUpdateController"];
    [self addTitle:@"动画重新更新约束" className:@"HJRemakeController"];
    [self addTitle:@"整体动画更新约束" className:@"HJTotalController"];
    [self addTitle:@"复合View循环约束" className:@"HJCompositeController"];
    [self addTitle:@"约束百分比" className:@"HJAspectFitController"];
    [self addTitle:@"基本动画" className:@"HJBasicAnimationController"];
    [self addTitle:@"ScrollView布局" className:@"HJScrollViewController"];
    [self addTitle:@"复杂ScrollView布局" className:@"HJScrollViewComplexController"];
    [self addTitle:@"TableView布局" className:@"HJTableViewController"];
    [self addTitle:@"Header/Footer Layout" className:@"HJHeaderFooterViewController"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma - mark getter方法
- (NSMutableArray *)titles {
    if (_titles == nil) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}
- (NSMutableArray *)classNames {
    if (_classNames == nil) {
        _classNames = [NSMutableArray array];
    }
    return _classNames;
}
#pragma - mark 添加cell
- (void)addTitle:(NSString * _Nonnull)title className:(NSString *_Nonnull)class {
    [self.titles addObject:title];
    [self.classNames addObject:class];
}
#pragma - mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < 2) {
        [self performSegueWithIdentifier:self.classNames[indexPath.row] sender:self.titles[indexPath.row]];
    } else {
        Class class = NSClassFromString(self.classNames[indexPath.row]);
        UIViewController *vc = [[class alloc] init];
        vc.title = self.titles[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    segue.destinationViewController.title = sender;
}
@end
