//
//  ViewController.m
//  Podinns
//
//  Created by apple on 2017/3/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "ManagerVController.h"
#import "UINavigationController+HJExtension.h"
#import "HJHeaderView.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
/*账户数组*/
@property(nonatomic, strong)NSMutableArray * accountA;
/*tableView*/
@property(nonatomic, strong)UITableView * tableView;
/*登录是否成功*/
@property(nonatomic, assign)BOOL isSuccess;
/*是否运行*/
@property(nonatomic, assign)BOOL isLoading;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.accountA removeAllObjects];
    [self.accountA addObjectsFromArray:[FMDBHandle queryAllAccount]];
    if (self.accountA.count == 0) {
        [self.navigationController showText:@"你还没有添加账号, 请先到设置中添加账号!!"];
    } else {
        [self.navigationController showText:[NSString stringWithFormat:@"检测到本地账号%lu个!", (unsigned long)self.accountA.count]];
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}
- (void)setup {
    self.navigationItem.title = @"布丁酒店账号管理工具";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:nil titleNormalColor:nil titleHighlightedColor:nil normalImage:@"setting" highlightedImage:@"setting" target:self action:@selector(addAccount:) edg:(UIEdgeInsetsZero)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:nil titleNormalColor:nil titleHighlightedColor:nil normalImage:@"one" highlightedImage:@"one" target:self action:@selector(oneKey:) edg:(UIEdgeInsetsZero)];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
- (void)oneKey:(UIButton *)button {
    if (self.accountA.count == 0) {
        [self show_Success:@"本地没有账号" delay:1];
        return;
    }
    if (self.isLoading) {
        return;
    }
    self.isLoading = true;
    //信号量
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    //串行队列
    dispatch_queue_t queue = dispatch_queue_create("podinns", DISPATCH_QUEUE_SERIAL);
    for (NSInteger i = 0; i <= self.accountA.count - 1; i++) {
        [self startWithAccount:self.accountA[i] section:i queue:queue semaphore: semaphore];
    }
    self.isLoading = false;
}

- (void)startWithAccount:(AccountVo *)account section:(NSInteger)section queue:(dispatch_queue_t)queue semaphore: semaphore {
    __block BOOL isSuccess = false;
    //登录
    [HJHttpManager requestSOAPData:kHOST soapBody:kLogin(account.userName, account.password, account.IsTravel) success:^(id responseObject) {
        if ([responseObject hasPrefix:@"OK"]) {
            XHJLog(@"11111===登录成功");
            //成功
            account.last_loginDate = [[NSDate date] stringWithFormatter:SQLDataFormatter];
            account.isAvailable = 1;
            [FMDBHandle updateAccountWith:account];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self show_Success:[NSString stringWithFormat:@"%@登陆成功", account.userName] delay:1];
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
            });
            dispatch_semaphore_signal(semaphore);  //发送一个信
        } else {
            //登录失败
            XHJLog(@"11111===登录失败");
            dispatch_async(dispatch_get_main_queue(), ^{
                [self show_Success:[NSString stringWithFormat:@"%@", responseObject] delay:1];
                account.isAvailable = 0;
                [FMDBHandle updateAccountWith:account];
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimationFade)];
            });
            dispatch_semaphore_signal(semaphore);  //发送一个信号
        }
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self show_Success:@"网络状态错误, 请检查网络!" delay:1];
        });
        XHJLog(@"11111===登录网络错误");
        dispatch_semaphore_signal(semaphore);  //发送一个信号
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    

    
    
    
    /*
     //登录
     [HJHttpManager requestSOAPData:kHOST soapBody:kLogin(account.userName, account.password, account.IsTravel) success:^(id responseObject) {
     if ([responseObject hasPrefix:@"OK"]) {
     //成功
     account.last_loginDate = [[NSDate date] stringWithFormatter:SQLDataFormatter];
     account.isAvailable = 1;
     self.isSuccess = true;
     [FMDBHandle updateAccountWith:account];
     dispatch_async(dispatch_get_main_queue(), ^{
     [self show_Success:[NSString stringWithFormat:@"%@登陆成功", account.userName] delay:1];
     [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
     });
     
     
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     //判断是否签到过了
     if (![NSDate dateFromString:account.last_signDate dateFormatter:SQLDataFormatter].isToday) {
     //签到
     [[HJHttpManager sharedInstance] synRequestJSONWithURL:kSign type:(RequestTypePost) paramObject:nil paramDictionary:nil progress:nil success:^(id responseObject) {
     NSDictionary *dic = responseObject;
     dispatch_async(dispatch_get_main_queue(), ^{
     if ([dic[@"Text"] isEqualToString:@"OK"]) {
     [self show_Success:[NSString stringWithFormat:@"%@签到成功", account.userName] delay:1];
     } else {
     [self show_Success:[NSString stringWithFormat:@"%@%@", account.userName, dic[@"Text"]] delay:1];
     }
     account.last_signDate = [[NSDate date] stringWithFormatter:SQLDataFormatter];
     [FMDBHandle updateAccountWith:account];
     [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimationFade)];
     });
     } failure:^(NSError *error) {
     dispatch_async(dispatch_get_main_queue(), ^{
     [self show_Error:[NSString stringWithFormat:@"签到--网络请求失败!!"] delay:1];
     });
     }];
     } else {
     dispatch_async(dispatch_get_main_queue(), ^{
     [self show_Warning:[NSString stringWithFormat:@"%@今天已经签到过了", account.userName] delay:1];
     });
     }
     });
     
     
     //每日积分抽奖
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     if (![NSDate dateFromString:account.last_lotteryDate dateFormatter:SQLDataFormatter].isToday) {
     
     [[HJHttpManager sharedInstance] synRequestJSONWithURL:kDayLottery type:(RequestTypePost) paramObject:nil paramDictionary:nil progress:nil success:^(id responseObject) {
     account.last_lotteryDate = [[NSDate date] stringWithFormatter:SQLDataFormatter];
     [FMDBHandle updateAccountWith:account];
     dispatch_async(dispatch_get_main_queue(), ^{
     [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimationFade)];
     [self show_Success:[NSString stringWithFormat:@"你获得%@",responseObject[@"msg"]] delay:1];
     });
     } failure:^(NSError *error) {
     dispatch_async(dispatch_get_main_queue(), ^{
     [self show_Error:[NSString stringWithFormat:@"%@积分抽奖--网络请求失败!!", account.userName] delay:1];
     });
     }];
     } else {
     dispatch_async(dispatch_get_main_queue(), ^{
     [self show_Warning:[NSString stringWithFormat:@"%@今天积分抽奖已经抽过了", account.userName] delay:1];
     });
     }
     });
     
     
     //周抽奖
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     NSInteger day = [NSDate date].day;
     NSInteger week = 0;
     if (day >= 1 && day <= 7) {
     week = 1;
     } else if (day >= 8 && day <= 14) {
     week = 2;
     } else if (day >= 15 && day <= 21) {
     week = 3;
     } else if (day >= 22 && day <= 28) {
     week = 4;
     } else {
     week = 4;
     }
     [[HJHttpManager sharedInstance] synRequestJSONWithURL:kWeekLottery(week) type:(RequestTypePost) paramObject:nil paramDictionary:nil progress:nil success:^(id responseObject) {
     if ([[responseObject[@"Error"] stringValue] isEqual:@"1"]) {
     dispatch_async(dispatch_get_main_queue(), ^{
     [self show_Error:[NSString stringWithFormat:@"%@", responseObject[@"Text"]] delay:1];
     if ([responseObject[@"Text"] isEqualToString:@"本周您已抽奖"]) {
     account.last_weekLotteryDate = [[NSDate date] stringWithFormatter:SQLDataFormatter];
     [FMDBHandle updateAccountWith:account];
     [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimationFade)];
     }
     });
     } else if ([[responseObject[@"Msg"] stringValue] isEqualToString:@"1"]) {
     account.last_weekLotteryDate = [[NSDate date] stringWithFormatter:SQLDataFormatter];
     [FMDBHandle updateAccountWith:account];
     dispatch_async(dispatch_get_main_queue(), ^{
     [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimationFade)];
     [self show_Success:[NSString stringWithFormat:@"你获得%@",[responseObject[@"Text"]  isEqual: @"145"] ? @"10积分" : @"其他奖励"] delay:1];
     });
     }
     
     } failure:^(NSError *error) {
     dispatch_async(dispatch_get_main_queue(), ^{
     [self show_Error:[NSString stringWithFormat:@"周抽奖--网络连接错误!!"] delay:1];
     });
     }];
     });
     
     //获取积分
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     [[HJHttpManager sharedInstance] synRequestJSONWithURL:kTotalBonus([NSDate currentTimestampStringWithType:(TimestampTypeMillisecond)]) type:(RequestTypeGet) paramObject:nil paramDictionary:nil progress:nil success:^(id responseObject) {
     NSString *total = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
     account.totalBonus = [NSString stringWithFormat:@"%@分", total];
     [FMDBHandle updateAccountWith:account];
     dispatch_async(dispatch_get_main_queue(), ^{
     [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimationFade)];
     [self show_Success:[NSString stringWithFormat:@"%@共有%@分", account.userName, total] delay:1];
     });
     } failure:^(NSError *error) {
     dispatch_async(dispatch_get_main_queue(), ^{
     [self show_Error:[NSString stringWithFormat:@"获取积分--网络连接错误!!"] delay:1];
     });
     }];
     });
     
     } else {
     //登录失败
     dispatch_async(dispatch_get_main_queue(), ^{
     [self show_Success:[NSString stringWithFormat:@"%@", responseObject] delay:1];
     account.isAvailable = 0;
     [FMDBHandle updateAccountWith:account];
     [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimationFade)];
     self.isSuccess = false;
     });
     }
     } failure:^(NSError *error) {
     dispatch_async(dispatch_get_main_queue(), ^{
     [self show_Success:@"网络状态错误, 请检查网络!" delay:1];
     });
     }];
     
     */
}

- (void)addAccount:(UIButton *)button {
    [self.navigationController pushViewController:[[ManagerVController alloc] init] animated:true];
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
            object.sectionFooterHeight = 0;
            object.sectionHeaderHeight = 44;
            object;
        });
    }
    return _tableView;
}

#pragma - mark UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.accountA.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccountVo *account = self.accountA[indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"登录";
        cell.detailTextLabel.text = [NSDate dateFromString:account.last_loginDate dateFormatter:SQLDataFormatter].isToday ? @"今日已登录" : @"今天未登录";
        cell.imageView.image= [UIImage imageNamed:@"login_time"];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"签到";
        cell.detailTextLabel.text = [NSDate dateFromString:account.last_signDate dateFormatter:SQLDataFormatter].isToday ? @"今天已签到" : @"今天未签到";
        cell.imageView.image= [UIImage imageNamed:@"sign_time"];
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"每日免费抽奖";
        cell.detailTextLabel.text = [NSDate dateFromString:account.last_lotteryDate dateFormatter:SQLDataFormatter].isToday ? @"今日积分抽奖已完成" : @"今日积分抽奖未抽";
        cell.imageView.image= [UIImage imageNamed:@"lottery_time"];
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"周抽奖";
        cell.detailTextLabel.text = [NSDate dateFromString:account.last_weekLotteryDate dateFormatter:SQLDataFormatter].isThisWeek ? @"本周抽奖已完成" : @"本周抽奖未抽";
        cell.imageView.image= [UIImage imageNamed:@"weekLottery_time"];
    } else {
        cell.textLabel.text = @"总积分";
        cell.detailTextLabel.text = account.totalBonus.length == 0 ? @"N/A" : account.totalBonus;
        cell.imageView.image= [UIImage imageNamed:@"bonus_total"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HJHeaderView *headerView = [HJHeaderView headerViewWith:tableView];
    AccountVo *account = self.accountA[section];
    headerView.account = account;
    __weak __typeof(self)weakself = self;
    [headerView setHeaderBlock:^(HJHeaderView *header) {
        //        [weakself startLoginWith:account secion:section];
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
        //串行队列
        dispatch_queue_t queue = dispatch_queue_create("podinns", DISPATCH_QUEUE_SERIAL);
        [weakself startWithAccount:account section:section queue:queue semaphore:semaphore];
    }];
    return headerView;
}
@end
