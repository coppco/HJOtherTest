//
//  NSDate+HJExtension.h
//  DevoutCat
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 时间戳类型

 - TimestampTypeSecond: 10位时间戳, 精确到秒
 - TimestampTypeMillisecond: 13位时间戳, 精确到毫秒
 */
typedef NS_ENUM(NSInteger, TimestampType) {
    TimestampTypeSecond,
    TimestampTypeMillisecond
};

/*SQL数据库常用格式*/
UIKIT_EXTERN NSString *const SQLDataFormatter;

@interface NSDate (HJExtension)

/**年*/
- (NSInteger)year;
/**月*/
- (NSInteger)month;
/**日*/
- (NSInteger)day;
/**周*/
- (NSInteger)weekday;
/**时*/
- (NSInteger)hour;
/**分*/
- (NSInteger)minute;
/**秒*/
- (NSInteger)second;
/*月中第几周*/
- (NSInteger)weekOfMonth;
/**
 是否闰年

 @return yes or no
 */
- (BOOL)isLeapYear;

/**
 是否是今天

 @return yes or no
 */
- (BOOL)isToday;

/**
 是否本周

 @return yes or no
 */
- (BOOL)isThisWeek;

- (NSDate *)dateByAddYear:(NSInteger)year;
- (NSDate *)dateByAddMonth:(NSInteger)month;
- (NSDate *)dateByAddDay:(NSInteger)day;
- (NSDate *)dateByAddHour:(NSInteger)hour;
- (NSDate *)dateByAddMinutes:(NSInteger)minutes;
- (NSDate *)dateByAddSecond:(NSInteger)second;

/**
 当前时间的时间戳, since1970

 @param type 时间戳类型
 @return 返回当前时间戳NSString
 */
+ (NSString *)currentTimestampStringWithType:(TimestampType)type;

/**
 NSDate的时间戳, since1970

 @param type 时间戳类型
 @return 返回NSDate对象的时间戳NSString
 */
- (NSString *)timestampStringWithType:(TimestampType)type;

/**
 日期格式化

 @param dateFormatter 格式
 @return 返回日期的格式化NSStirng
 */
- (NSString *)stringWithFormatter:(NSString *)dateFormatter;

/**
 从字符串里面根据格式化形式返回NSDate

 @param dateString 时间字符串
 @param dateFormatter 格式化字符串
 @return 返回日期NSDate
 */
+ (NSDate *)dateFromString:(NSString *)dateString dateFormatter:(NSString *)dateFormatter;
@end
