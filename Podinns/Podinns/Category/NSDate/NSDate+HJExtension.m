//
//  NSDate+HJExtension.m
//  DevoutCat
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NSDate+HJExtension.h"
NSString *const SQLDataFormatter = @"yyyy-MM-dd HH:mm:ss";
@implementation NSDate (HJExtension)

- (NSDateComponents *)components {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.locale = [NSLocale currentLocale];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekOfMonth;
    NSDateComponents *components = [calendar components:unit fromDate:self];
    return components;
}

- (NSInteger)year {
    return [self components].year;
}
- (NSInteger)month {
    return [self components].month;
}
- (NSInteger)day {
    return [self components].day;
}
- (NSInteger)weekday {
    return [self components].weekday;
}
- (NSInteger)hour {
    return [self components].hour;
}
- (NSInteger)minute {
    return [self components].minute;
}
- (NSInteger)second {
    return [self components].second;
}
- (NSInteger)weekOfMonth {
    return [self components].weekOfMonth;
}
- (BOOL)isLeapYear {
    return (self.year % 400  == 0) || ((self.year % 4 == 0 ) && (self.year % 100 != 0));
}
- (BOOL)isToday {
    if (fabs([self timeIntervalSinceNow]) >= 60 * 60 * 24) {
        return false;
    }
    return self.day == [NSDate date].day;
}
- (BOOL)isThisWeek {
    if (fabs([self timeIntervalSinceNow]) >= 60 * 60 * 24 * 7) {
        return false;
    }
    return self.weekOfMonth == [NSDate date].weekOfMonth;
}

- (NSDate *)dateByAddYear:(NSInteger)year {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = year;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:(NSCalendarWrapComponents)];
}
- (NSDate *)dateByAddMonth:(NSInteger)month {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = month;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:(NSCalendarWrapComponents)];
}
- (NSDate *)dateByAddDay:(NSInteger)day {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = day;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:(NSCalendarWrapComponents)];
}
- (NSDate *)dateByAddHour:(NSInteger)hour {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.hour = hour;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:(NSCalendarWrapComponents)];
}
- (NSDate *)dateByAddMinutes:(NSInteger)minutes {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.minute = minutes;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:(NSCalendarWrapComponents)];
}
- (NSDate *)dateByAddSecond:(NSInteger)second {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.second = second;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:(NSCalendarWrapComponents)];
}

+ (NSString *)currentTimestampStringWithType:(TimestampType)type {
    return [NSString stringWithFormat:@"%.0f", type == TimestampTypeSecond ? [NSDate date].timeIntervalSince1970 : [NSDate date].timeIntervalSince1970 * 1000];
}
- (NSString *)timestampStringWithType:(TimestampType)type {
    return [NSString stringWithFormat:@"%.0f", type == TimestampTypeSecond ? self.timeIntervalSince1970 : self.timeIntervalSince1970 * 1000];
}

- (NSString *)stringWithFormatter:(NSString *)dateFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormatter;
    return [formatter stringFromDate:self];
}
+ (NSDate *)dateFromString:(NSString *)dateString dateFormatter:(NSString *)dateFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormatter;
    return [formatter dateFromString:dateString];
}
@end
