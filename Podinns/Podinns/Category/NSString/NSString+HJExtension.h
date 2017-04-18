//
//  NSString+HJExtension.h
//  DevoutCat
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 apple. All rights reserved.
//  需要导入

#import <Foundation/Foundation.h>
#import "NSData+HJExtension.h"


@interface NSString (HJExtension)

/**
 加密字符串, 返回NSString

 @param type 加密方式
 @return 返回加密后的NSString
 */
- (NSString *)safeStringWithType:(SafeType)type;

/**
 加密字符串, 返回NSData
 
 @param type 加密方式
 @return 返回加密后的NSData
 */
- (NSData *)safeDataWithType:(SafeType)type;

/**
 crc32加密

 @return 返回crc32加密后的字符串
 */
- (NSString *)safeCRC32;

/**
 HMAC加密, 返回加密后的字符串
 
 @param type 加密方式
 @param key key
 @return 返回加密后的NSStirng
 */
- (NSString *)safeHMACStringWithType:(CCHmacAlgorithm)type key:(NSString *)key;

/**
 MD5加密

 @return 返回MD5加密后的字符串
 */
- (NSString *)md5String;
@end
