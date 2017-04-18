//
//  AddAccountController.h
//  Podinns
//
//  Created by apple on 2017/3/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AccountVo;
@interface AddAccountController : UIViewController
/*账号信息*/
@property(nonatomic, strong)AccountVo * account;
/*删除*/
@property(nonatomic, copy)void (^didDelete)(AccountVo *account);

@end
