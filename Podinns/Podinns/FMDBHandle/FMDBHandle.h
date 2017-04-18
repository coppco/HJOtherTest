//
//  FMDBHandle.h
//  Podinns
//
//  Created by apple on 2017/3/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
#import "AccountVo.h"

@interface FMDBHandle : NSObject

/**
 数据库

 @return 返回数据库对象
 */
+ (FMDatabase *)sharedFMDatabase;

/**
 数据库操作队列, 它是线程安全的

 @return 返回数据库操作队列
 */
+ (FMDatabaseQueue *)shareFMDatabaseQueue;

/**
 创建用户存储表

 @return 返回成功与否
 */
+ (BOOL)creatUserTable;

/**
 添加用户

 @param userName 用户名
 @param password 密码
 @param IsTravel 是否是商旅卡 0 ---> 不是 , 1 ---> 是
 @return 返回成功与否
 */
+ (BOOL)addAccountWithUserName:(NSString *)userName password:(NSString *)password IsTravel:(NSInteger)IsTravel;

/**
 根据用户名查询数据库中是否已经存在

 @param userName 用户名
 @return 返回存在与否
 */
+ (BOOL)isExistsForUserName:(NSString *)userName;
/**
 根据用户名查询数据库

 @param userName 用户名
 @return 存在返回对应账户, 否则返回nil
 */
+ (AccountVo *)queryAccountWithUserName:(NSString *)userName;

/**
 更新用户信息

 @param account 用户信息
 @return 返回成功与否
 */
+ (BOOL)updateAccountWith:(AccountVo *)account;

/**
 根据用户名从数据库删除账户

 @param userName 用户名
 @return 返回成功与否
 */
+ (BOOL)deleteAccountWith:(NSString *)userName;

/**
 查询数据中所有数据

 @return 返回一个数组
 */
+ (NSArray <AccountVo *>*)queryAllAccount;

/**
 清除用户信息表

 @return 返回成功与否
 */
+ (BOOL)dropAccountTable;
@end
