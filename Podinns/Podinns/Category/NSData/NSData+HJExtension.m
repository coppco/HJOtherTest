//
//  NSData+HJExtension.m
//  DevoutCat
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NSData+HJExtension.h"


@implementation NSData (HJExtension)

- (NSData *)safeDataWithType:(SafeType)type {
    if (!self) {
        return nil;
    }
    NSData *encryptData = nil;
    switch (type) {
        case SafeTypeMD2:
        {
            unsigned char result[CC_MD2_DIGEST_LENGTH];
            CC_MD2(self.bytes, (CC_LONG)self.length, result);
            encryptData = [NSData dataWithBytes:result length:CC_MD2_DIGEST_LENGTH];
        }
            break;
        case SafeTypeMD4:
        {
            unsigned char result[CC_MD4_DIGEST_LENGTH];
            CC_MD4(self.bytes, (CC_LONG)self.length, result);
            encryptData = [NSData dataWithBytes:result length:CC_MD4_DIGEST_LENGTH];
        }
            break;
        case SafeTypeMD5:
        {
            unsigned char result[CC_MD5_DIGEST_LENGTH];
            CC_MD5(self.bytes, (CC_LONG)self.length, result);
            encryptData = [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
        }
            break;
        case SafeTypeSHA1:
        {
            unsigned char result[CC_SHA1_DIGEST_LENGTH];
            CC_SHA1(self.bytes, (CC_LONG)self.length, result);
            encryptData = [NSData dataWithBytes:result length:CC_SHA1_DIGEST_LENGTH];
        }
            break;
        case SafeTypeSHA224:
        {
            unsigned char result[CC_SHA224_DIGEST_LENGTH];
            CC_SHA224(self.bytes, (CC_LONG)self.length, result);
            encryptData = [NSData dataWithBytes:result length:CC_SHA224_DIGEST_LENGTH];
        }
            break;
        case SafeTypeSHA256:
        {
            unsigned char result[CC_SHA256_DIGEST_LENGTH];
            CC_SHA256(self.bytes, (CC_LONG)self.length, result);
            encryptData = [NSData dataWithBytes:result length:CC_SHA256_DIGEST_LENGTH];
        }
            break;
        case SafeTypeSHA384:
        {
            unsigned char result[CC_SHA384_DIGEST_LENGTH];
            CC_SHA384(self.bytes, (CC_LONG)self.length, result);
            encryptData = [NSData dataWithBytes:result length:CC_SHA384_DIGEST_LENGTH];
        }
            break;
        case SafeTypeSHA512:
        {
            unsigned char result[CC_SHA512_DIGEST_LENGTH];
            CC_SHA512(self.bytes, (CC_LONG)self.length, result);
            encryptData = [NSData dataWithBytes:result length:CC_SHA512_DIGEST_LENGTH];
        }
            break;
        default:
            return nil;
            break;
    }
    return encryptData;
}

- (NSString *)safeStringWithType:(SafeType)type {
    if (!self) {
        return nil;
    }
    NSString *encryptString;
    switch (type) {
        case SafeTypeMD2:
        {
            unsigned char result[CC_MD2_DIGEST_LENGTH];
            CC_MD2(self.bytes, (CC_LONG)self.length, result);
            encryptString = [NSString stringWithFormat:
                             @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                             result[0], result[1], result[2], result[3],
                             result[4], result[5], result[6], result[7],
                             result[8], result[9], result[10], result[11],
                             result[12], result[13], result[14], result[15]
                             ];
        }
            break;
        case SafeTypeMD4:
        {
            unsigned char result[CC_MD4_DIGEST_LENGTH];
            CC_MD4(self.bytes, (CC_LONG)self.length, result);
            encryptString = [NSString stringWithFormat:
                             @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                             result[0], result[1], result[2], result[3],
                             result[4], result[5], result[6], result[7],
                             result[8], result[9], result[10], result[11],
                             result[12], result[13], result[14], result[15]
                             ];
        }
            break;
        case SafeTypeMD5:
        {
            unsigned char result[CC_MD5_DIGEST_LENGTH];
            CC_MD5(self.bytes, (CC_LONG)self.length, result);
            encryptString = [NSString stringWithFormat:
                             @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                             result[0], result[1], result[2], result[3],
                             result[4], result[5], result[6], result[7],
                             result[8], result[9], result[10], result[11],
                             result[12], result[13], result[14], result[15]
                             ];
        }
            break;
        case SafeTypeSHA1:
        {
            unsigned char result[CC_SHA1_DIGEST_LENGTH];
            CC_SHA1(self.bytes, (CC_LONG)self.length, result);
            NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
            for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
                [hash appendFormat:@"%02x", result[i]];
            }
            encryptString = hash;
        }
            break;
        case SafeTypeSHA224:
        {
            unsigned char result[CC_SHA224_DIGEST_LENGTH];
            CC_SHA224(self.bytes, (CC_LONG)self.length, result);
            NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA224_DIGEST_LENGTH * 2];
            for (int i = 0; i < CC_SHA224_DIGEST_LENGTH; i++) {
                [hash appendFormat:@"%02x", result[i]];
            }
            encryptString = hash;
        }
            break;
        case SafeTypeSHA256:
        {
            unsigned char result[CC_SHA256_DIGEST_LENGTH];
            CC_SHA256(self.bytes, (CC_LONG)self.length, result);
            NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
            for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
                [hash appendFormat:@"%02x", result[i]];
            }
            encryptString = hash;
        }
            break;
        case SafeTypeSHA384:
        {
            unsigned char result[CC_SHA384_DIGEST_LENGTH];
            CC_SHA384(self.bytes, (CC_LONG)self.length, result);
            NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA384_DIGEST_LENGTH * 2];
            for (int i = 0; i < CC_SHA384_DIGEST_LENGTH; i++) {
                [hash appendFormat:@"%02x", result[i]];
            }
            encryptString = hash;
        }
            break;
        case SafeTypeSHA512:
        {
            unsigned char result[CC_SHA512_DIGEST_LENGTH];
            CC_SHA512(self.bytes, (CC_LONG)self.length, result);
            NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
            for (int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
                [hash appendFormat:@"%02x", result[i]];
            }
            encryptString = hash;
        }
            break;
        default:
            return nil;
            break;
    }
    return encryptString;
}

- (NSString *)safeCRC32 {
    if (!self) {
        return nil;
    }
    uLong result = crc32(0, [self bytes], (uInt)self.length);
    return [NSString stringWithFormat:@"%08x", (uint32_t)result];
}

- (NSString *)safeHMACStringWithType:(CCHmacAlgorithm)type key:(NSString *)key {
    if (!self) {
        return nil;
    }
    size_t size;
    switch (type) {
        case kCCHmacAlgMD5:
            size = CC_MD5_DIGEST_LENGTH;
            break;
        case kCCHmacAlgSHA1:
            size = CC_SHA1_DIGEST_LENGTH;
            break;
        case kCCHmacAlgSHA224:
            size = CC_SHA224_DIGEST_LENGTH;
            break;
        case kCCHmacAlgSHA256:
            size = CC_SHA256_DIGEST_LENGTH;
            break;
        case kCCHmacAlgSHA384:
            size = CC_SHA384_DIGEST_LENGTH;
            break;
        case kCCHmacAlgSHA512:
            size = CC_SHA512_DIGEST_LENGTH;
            break;
        default:
            return nil;
            break;
    }
    unsigned char result[size];
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    CCHmac(type, cKey, strlen(cKey), self.bytes, self.length, result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:size * 2];
    for (int i = 0; i < size; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}
@end
