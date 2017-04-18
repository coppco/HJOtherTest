//
//  AccountVo.h
//  Podinns
//
//  Created by apple on 2017/3/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountVo : NSObject
/*用户名*/
@property(nonatomic, copy)NSString *userName;
/*密码*/
@property(nonatomic, copy)NSString *password;
/*是否商旅卡, 0 ---> 不是, 1 ----> 是*/
@property(nonatomic, assign)int IsTravel;
/**
 账户是否有效, 0 --->  无效, 1 -----> 有效, 2 -------> 未验证
 */
@property(nonatomic, assign)NSInteger isAvailable;
/*最后登录时间*/
@property(nonatomic, copy)NSString *last_loginDate;
/*最后签到时间*/
@property(nonatomic, copy)NSString *last_signDate;
/*最后免费抽奖时间*/
@property(nonatomic, copy)NSString *last_lotteryDate;
/*最后周抽奖时间*/
@property(nonatomic, copy)NSString *last_weekLotteryDate;
/*总积分*/
@property(nonatomic, copy)NSString *totalBonus;
/*数据库序列号*/
@property(nonatomic, assign)NSInteger dbId;
@end
