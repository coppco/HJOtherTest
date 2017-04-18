//
//  NSString+HJExtension.m
//  DevoutCat
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NSString+HJExtension.h"

@implementation NSString (HJExtension)
- (NSString *)safeStringWithType:(SafeType)type {
    return [[self dataUsingEncoding:(NSUTF8StringEncoding)] safeStringWithType:type];
}

- (NSData *)safeDataWithType:(SafeType)type {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] safeDataWithType:type];
}

- (NSString *)safeCRC32 {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] safeCRC32];
}

- (NSString *)safeHMACStringWithType:(CCHmacAlgorithm)type key:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] safeHMACStringWithType:type key:key];
}
- (NSString *)md5String {
    return [self safeStringWithType:(SafeTypeMD5)];
}
@end
