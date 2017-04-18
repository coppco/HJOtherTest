//
//  ManagerVController.m
//  Podinns
//
//  Created by apple on 2017/3/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ManagerVController.h"
#import "AddAccountController.h"
#import "AccountTableViewCell.h"
@interface ManagerVController ()<UITableViewDelegate, UITableViewDataSource, UIViewControllerPreviewingDelegate>
/*用户信息表*/
@property(nonatomic, strong)NSMutableArray * accountA;
/*table*/
@property(nonatomic, strong)UITableView * tableView;
@end

@implementation ManagerVController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.accountA removeAllObjects];
    [self.accountA addObjectsFromArray:[FMDBHandle queryAllAccount]];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"管理账号";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:nil titleNormalColor:nil titleHighlightedColor:nil normalImage:@"add_normal" highlightedImage:@"add_press" target:self action:@selector(addAccount:) edg:(UIEdgeInsetsZero)];
    [self.accountA addObjectsFromArray:[FMDBHandle queryAllAccount]];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)addAccount:(UIButton *)button {
    [self.navigationController pushViewController:[[AddAccountController alloc] init] animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)accountA {
    if (!_accountA) {
        _accountA = [NSMutableArray array];
    }
    return _accountA;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = ({
            UITableView *object = [[UITableView alloc] initWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
            object.delegate = self;
            object.dataSource = self;
            [object registerNib:[UINib nibWithNibName:@"AccountTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
            object.rowHeight = 331;
            object.showsVerticalScrollIndicator = false;
            object.showsHorizontalScrollIndicator = false;
            object;
        });
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.accountA.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AccountVo *account = self.accountA[indexPath.section];
    cell.account = account;

    if (__iOS_9_0 && cell.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:self sourceView:cell];
    }
    return cell;
}

//侧滑按钮
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self deleteWithIndexPath:indexPath];
}
- (void)deleteWithIndexPath:(NSIndexPath *)indexPath {
    __weak __typeof(self)weakself = self;
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否确认删除账户" preferredStyle:(UIAlertControllerStyleAlert)];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {

    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"删除" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        [FMDBHandle deleteAccountWith:((AccountVo *)weakself.accountA[indexPath.section]).userName];
         [weakself.accountA removeObjectAtIndex:indexPath.section];
        [weakself.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:(UITableViewRowAnimationRight)];
        [self show_Success:@"删除成功!" delay:2];
    }]];
    [self presentViewController:alertVC animated:true completion:nil];
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AccountVo *account = self.accountA[indexPath.section];
    AddAccountController *vc = [[AddAccountController alloc] init];
    vc.account = account;
    [self.navigationController pushViewController:vc animated:true];
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location NS_AVAILABLE_IOS(9_0) {
    AddAccountController *vc = [[AddAccountController alloc] init];
//    vc.preferredContentSize = CGSizeMake(200, 200);
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)[previewingContext sourceView]];
    AccountVo *account = self.accountA[indexPath.section];
    vc.account = account;
    __weak __typeof(self)weakself = self;
    [vc setDidDelete:^(AccountVo *account) {
        [weakself.accountA removeObject:account];
        [weakself.tableView reloadData];
    }];
    return vc;
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit NS_AVAILABLE_IOS(9_0) {
    viewControllerToCommit.hidesBottomBarWhenPushed = true;
    [self showViewController:viewControllerToCommit sender:self];
}

@end
