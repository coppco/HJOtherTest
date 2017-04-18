//
//  FMDBHandle.m
//  Podinns
//
//  Created by apple on 2017/3/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FMDBHandle.h"


static FMDatabaseQueue *databaseQueue = nil;
static FMDatabase *database = nil;
@implementation FMDBHandle
+ (FMDatabase *)sharedFMDatabase {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!database) {
            database = [FMDatabase databaseWithPath:[self databaseFile]];
        }
    });
    return database;
}

+ (FMDatabaseQueue *)shareFMDatabaseQueue {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!databaseQueue) {
            databaseQueue = [FMDatabaseQueue databaseQueueWithPath:[self databaseFile]];
            XHJLog(@"%@", [self databaseFile]);
        }
    });
    return databaseQueue;
}

+ (BOOL)creatUserTable {
    BOOL result = false;
    FMDatabase *db = [self sharedFMDatabase];
    if (![db open]) {
            return result;
    }
    [db setShouldCacheStatements:true];
    result = [db executeUpdate:[NSString stringWithFormat:@"create table if not exists %@ (dbId integer primary key autoincrement not null, userName text, password text, isAvailable integer,IsTravel integer, last_loginDate text, last_signDate text, last_lotteryDate text, last_weekLotteryDate text, totalBonus text)", kAccountTable]];
    return result;
}

+ (BOOL)addAccountWithUserName:(NSString *)userName password:(NSString *)password IsTravel:(NSInteger)IsTravel {
    __block BOOL result = false;
    FMDatabaseQueue *queue = [self shareFMDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return;
        }
        [db setShouldCacheStatements:true];
        if (![db tableExists:kAccountTable]) {
            [self creatUserTable];
        }
        NSString *sql = nil;
//        if ([self isExistsForUserName:userName]) {
//            //已经存在
//            sql = [NSString stringWithFormat:@"update %@ set password = %@, set IsTravel = %ld where userName = %@", kAccountTable, password, (long)IsTravel, userName];
//        } else {
            //新添加
            sql = [NSString stringWithFormat:@"insert into %@ (userName, password, isAvailable, IsTravel) values('%@','%@', %d,%ld)", kAccountTable, userName, password, 2, (long)IsTravel];
//        }
        
        result = [db executeUpdate: sql];
        [db close];
    }];
    return result;
}

/**
 判断时候用户名是否存在

 @param userName 用户名
 @return 返回YES NO
 */
+ (BOOL)isExistsForUserName:(NSString *)userName {
    AccountVo *account = [self queryAccountWithUserName:userName];
    if (account == nil) {
        return false;
    }
    return true;
}

//根据用户名查询数据库
+ (AccountVo *)queryAccountWithUserName:(NSString *)userName {
    __block AccountVo *model = nil;
    FMDatabaseQueue *queue = [self shareFMDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return;
        }
        [db setShouldCacheStatements:true];
        
        if (![db tableExists:kAccountTable]) {
            [self creatUserTable];
            return;
        }
        FMResultSet *resultSet = [db executeQuery:[NSString stringWithFormat:@"select * from %@ where userName = %@", kAccountTable, userName]];
        if ([resultSet next]) {
            model = [[AccountVo alloc] init];
            model.userName = [resultSet stringForColumn:@"userName"];
            model.password = [resultSet stringForColumn:@"password"];
            model.IsTravel = [resultSet intForColumn:@"IsTravel"];
            model.isAvailable = [resultSet intForColumn:@"isAvailable"];
            model.last_signDate = [resultSet stringForColumn:@"last_signDate"];
            model.last_loginDate = [resultSet stringForColumn:@"last_loginDate"];
            model.last_lotteryDate = [resultSet stringForColumn:@"last_lotteryDate"];
            model.last_weekLotteryDate = [resultSet stringForColumn:@"last_weekLotteryDate"];
            model.totalBonus = [resultSet stringForColumn:@"totalBonus"];
            model.dbId = [resultSet intForColumn:@"dbId"];
        }
        [resultSet close];
        [db close];
    }];
    [queue close];
    return model;
}
//更新账户
+ (BOOL)updateAccountWith:(AccountVo *)account {
    __block BOOL result = false;
    FMDatabaseQueue *queue = [self shareFMDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:true];
        if (![db tableExists:kAccountTable]) {
            [self creatUserTable];
            return;
        }
//        NSDictionary *dic = account.mj_keyValues;
//        for (NSString *key in dic) {
//            if (dic[key] != nil && ![key isEqualToString:@"userName"]) {
//                result = [db executeUpdate:[NSString stringWithFormat:@"update %@ set %@ = %@ where userName = %@", kAccountTable, key, dic[key], account.userName]];
//            }
//        }
        result = [db executeUpdate:[NSString stringWithFormat:@"update %@ set password = '%@', isAvailable = %ld, isTravel = %d, last_loginDate = '%@', last_signDate = '%@', last_lotteryDate = '%@', last_weekLotteryDate = '%@', totalBonus = '%@', userName = '%@' where dbId = %ld" , kAccountTable, account.password, (long)account.isAvailable, account.IsTravel, (account.last_loginDate.length == 0 || [account.last_loginDate isEqualToString:@"(null)"]) ? @"" : account.last_loginDate, (account.last_signDate.length == 0 || [account.last_signDate isEqualToString:@"(null)"]) ? @"" : account.last_signDate, (account.last_lotteryDate.length == 0 || [account.last_lotteryDate isEqualToString:@"(null)"]) ? @"" : account.last_lotteryDate, (account.last_weekLotteryDate.length == 0 || [account.last_weekLotteryDate isEqualToString:@"(null)"]) ? @"" : account.last_weekLotteryDate, (account.totalBonus.length == 0 || [account.totalBonus isEqualToString:@"(null)"]) ? @"" : account.totalBonus, account.userName, (long)account.dbId]];
        [db close];
    }];
    return result;
}

+ (BOOL)deleteAccountWith:(NSString *)userName {
    __block BOOL result = false;
    FMDatabaseQueue *queue = [self shareFMDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:true];
        if (![db tableExists:kAccountTable]) {
            [self creatUserTable];
            return;
        }
        result = [db executeUpdate:[NSString stringWithFormat:@"delete from %@ where userName = %@", kAccountTable, userName]];
        [db close];
    }];
    return result;
}

+ (NSArray<AccountVo *> *)queryAllAccount {
    NSMutableArray *result = [NSMutableArray array];
    FMDatabaseQueue *queue = [self shareFMDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:true];
        if (![db tableExists:kAccountTable]) {
            [self creatUserTable];
            return;
        }
        
        FMResultSet *resultSet = [db executeQuery:[NSString stringWithFormat:@"select * from %@", kAccountTable]];
        while ([resultSet next]) {
            AccountVo *model = [[AccountVo alloc] init];
            model.userName = [resultSet stringForColumn:@"userName"];
            model.password = [resultSet stringForColumn:@"password"];
            model.IsTravel = [resultSet intForColumn:@"IsTravel"];
            model.isAvailable = [resultSet intForColumn:@"isAvailable"];
            model.last_signDate = [resultSet stringForColumn:@"last_signDate"];
            model.last_loginDate = [resultSet stringForColumn:@"last_loginDate"];
            model.last_lotteryDate = [resultSet stringForColumn:@"last_lotteryDate"];
            model.last_weekLotteryDate = [resultSet stringForColumn:@"last_weekLotteryDate"];
            model.totalBonus = [resultSet stringForColumn:@"totalBonus"];
            model.dbId = [resultSet intForColumn:@"dbId"];
            [result addObject:model];
        }
        [resultSet close];
        [db close];
    }];
    return result;
}

+ (BOOL)dropAccountTable {
    __block BOOL result = false;
    FMDatabaseQueue *queue = [self shareFMDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            return ;
        }
        [db setShouldCacheStatements:true];
        if (![db tableExists:kAccountTable]) {
            [self creatUserTable];
            return;
        }
        result = [db executeUpdate:@"DROP TABLE %@", kAccountTable];
        [db close];
    }];
    return result;
}

//本地数据库路径
+ (NSString *)databaseFile {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).firstObject stringByAppendingPathComponent:kDatabaseName];
}

@end
