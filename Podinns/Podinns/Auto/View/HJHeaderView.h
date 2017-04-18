//
//  HJHeaderView.h
//  Podinns
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AccountVo;
@interface HJHeaderView : UITableViewHeaderFooterView
+ (HJHeaderView *)headerViewWith:(UITableView *)tableView;
/*账号信息*/
@property(nonatomic, strong)AccountVo * account;
/*点击block*/
@property(nonatomic, copy)void (^headerBlock)(HJHeaderView *);
@end
