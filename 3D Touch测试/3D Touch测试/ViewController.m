//
//  ViewController.m
//  3D Touch测试
//
//  Created by apple on 2017/3/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIViewControllerPreviewingDelegate>
/*tableView*/
@property(nonatomic, strong)UITableView * tableView;
@end

@implementation ViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = ({
            UITableView *object = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
            object.delegate= self;
            object.dataSource = self;
            object;
        });
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    [self.view addSubview:self.tableView];
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
//        if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
//            [self registerForPreviewingWithDelegate:self sourceView:self.tableView];
//        }
//    }
}
#pragma - mark UIViewControllerPreviewingDelegate
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location NS_AVAILABLE_IOS(9_0) {
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.preferredContentSize = CGSizeMake(200, 200);
    detailVC.view.backgroundColor = [UIColor blueColor];
    //[previewingContext sourceView]拿到对应的cell；
    NSIndexPath *indexPath = [_tableView indexPathForCell:(UITableViewCell* )[previewingContext sourceView]];
    NSLog(@"%@", indexPath);
    return detailVC;
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit NS_AVAILABLE_IOS(9_0) {
    [self.navigationController pushViewController:viewControllerToCommit animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma - mark UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue2) reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ld", (long)indexPath.section, (long)indexPath.row];
    //注册peek
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            [self registerForPreviewingWithDelegate:self sourceView:cell];
        }
    }

    return cell;
}
@end
