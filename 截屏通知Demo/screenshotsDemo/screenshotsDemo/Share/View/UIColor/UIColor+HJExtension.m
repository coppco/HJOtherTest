//
//  UIView+HJExtersion.m
//  HJOrange
//
//  Created by apple on 2017/2/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UIColor+HJExtension.h"

static BOOL hexStrToRGBA(NSString *str,
                         CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a) {
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([str hasPrefix:@"#"]) {
        str = [str substringFromIndex:1];
    } else if ([str hasPrefix:@"0X"] || [str hasPrefix:@"0x"]) {
        str = [str substringFromIndex:2];
    }
    
    NSUInteger length = str.length;
    //         RGB            RGBA          RRGGBB        RRGGBBAA
    if (length != 3 && length != 4 && length != 6 && length != 8) {
        return false;
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:str];
    unsigned int result = 0;
    if ([scanner scanHexInt:&result]) {
        if (length == 3) {
            //RGB
            *r = ((result & 0xF00) >> 8) / 15.0;
            *g = ((result & 0x0F0) >> 4) / 15.0;
            *b = (result & 0x00F) / 15.0;
            *a = 1;
        } else if (length == 4) {
            //RGBA
            *r = ((result & 0xF000) >> 12) / 15.0;
            *g = ((result & 0x0F00) >> 8) / 15.0;
            *b = ((result & 0x00F0) >> 4) / 15.0;
            *a = (result & 0x000F) / 15.0;
        } else if (length == 6) {
            //RRGGBB
            *r = ((result & 0xFF0000) >> 16) / 255.0;
            *g = ((result & 0x00FF00) >> 8) / 255.0;
            *b = (result & 0x0000FF) / 255.0;
            *a = 1;
        } else if (length == 8) {
            //RRGGBBAA
            *r = ((result & 0xFF000000) >> 24) / 255.0;
            *g = ((result & 0x00FF0000) >> 16) / 255.0;
            *b = ((result & 0x0000FF00) >> 8) / 255.0;
            *a = (result & 0x000000FF) / 255.0;
        }
        return true;
    } else {
        return  false;
    }
}
@implementation UIColor (HJExternsion)

+ (instancetype)colorFromHexString:(NSString *)hex {
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    
    if (hexStrToRGBA(hex, &red, &green, &blue, &alpha)) {
        return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    }
    return nil;
}

+ (UIColor *)colorFromRGBValue:(uint32_t)rgbValue {
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0f
                           green:((rgbValue & 0xFF00) >> 8) / 255.0f
                            blue:(rgbValue & 0xFF) / 255.0f
                           alpha:1];
}

+ (UIColor *)colorFromRGBAValue:(uint32_t)rgbaValue {
    return [UIColor colorWithRed:((rgbaValue & 0xFF000000) >> 24) / 255.0f
                           green:((rgbaValue & 0xFF0000) >> 16) / 255.0f
                            blue:((rgbaValue & 0xFF00) >> 8) / 255.0f
                           alpha:(rgbaValue & 0xFF) / 255.0f];
}
+ (instancetype)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a {
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a / 255.0];
}

+ (instancetype)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b {
    return [UIColor colorWithR:r G:g B:b A:255];
}
+ (instancetype)randomColor {
    return [UIColor colorWithR:arc4random() % 256 G:arc4random() % 256 B:arc4random() % 256 A:255];
}
@end
