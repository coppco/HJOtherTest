//
//  NSData+HJExtension.h
//  DevoutCat
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>  //加密用到
#include <zlib.h>  //crc32 用到  crc32需要导入libz.tbd
/**
 加密方式

 - SafeTypeMD2: MD2
 - SafeTypeMD4: MD4
 - SafeTypeMD5: MD5
 - SafeTypeSHA1: SHA1
 - SafeTypeSHA224: SHA224
 - SafeTypeSHA256: SHA256
 - SafeTypeSHA384: SHA384
 - SafeTypeSHA512: SHA512
 */
typedef NS_ENUM(NSInteger, SafeType) {
    SafeTypeMD2,
    SafeTypeMD4,
    SafeTypeMD5,
    SafeTypeSHA1,
    SafeTypeSHA224,
    SafeTypeSHA256,
    SafeTypeSHA384,
    SafeTypeSHA512
};

@interface NSData (HJExtension)

/**
 加密NSData, 返回NSData

 @param type 加密方式
 @return 返回NSData
 */
- (NSData *)safeDataWithType:(SafeType)type;

/**
 加密NSData, 返回NSString

 @param type 加密方式
 @return 返回NSString
 */
- (NSString *)safeStringWithType:(SafeType)type;

/**
 crc32加密, 返回NSString

 @return 返回crc32加密的字符串
 */
- (NSString *)safeCRC32;

/**
 HMAC加密, 返回加密后的字符串

 @param type 加密方式
 @param key key
 @return 返回加密后的NSStirng
 */
- (NSString *)safeHMACStringWithType:(CCHmacAlgorithm)type key:(NSString *)key;
@end
