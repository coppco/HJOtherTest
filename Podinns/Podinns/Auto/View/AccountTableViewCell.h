//
//  AccountTableViewCell.h
//  Podinns
//
//  Created by apple on 2017/3/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AccountVo;
@interface AccountTableViewCell : UITableViewCell
/*用户信息*/
@property(nonatomic, strong)AccountVo * account;
@end
