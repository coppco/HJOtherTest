//
//  AppDefine.h
//  DevoutCat
//
//  Created by apple on 2017/2/22.
//  Copyright © 2017年 apple. All rights reserved.
//  App宏定义

#ifndef AppDefine_h
#define AppDefine_h

/*本地数据库名称*/
#define kDatabaseName @"Podinns.sqlite"

/*用户信息表*/
#define kAccountTable @"Account"

/*服务器地址*/
#define kHOST @"https://api.podinns.com/wapService.asmx"

//登录 soap
#define kLogin(userName, password, isTravle) @{@"method":@"Login", @"userName":userName, @"password":password, @"IsTravel":[NSNumber numberWithInt:isTravle]}

//退出登录
//@{@"method":@"LoginOut2"}

//签到 post
#define kSign @"http://touch.podinns.com/MobileA/SignToday"
//每日积分抽奖 post
#define kDayLottery @"http://touch.podinns.com/Activity/FenLottery2014"
//周抽奖 post
#define kWeekLottery(week) [NSString stringWithFormat:@"http://touch.podinns.com/MobileA/SignLottery?num=%d", week]

//总积分
#define kTotalBonus(time) [NSString stringWithFormat:@"http://touch.podinns.com/Activity/GetUserFen?_=%@", time]
#endif /* AppDefine_h */
