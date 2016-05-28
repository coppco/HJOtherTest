//
//  CaculatorMaker.m
//  ReactiveCocoaDemo
//
//  Created by coco on 16/5/13.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "CaculatorMaker.h"

@implementation CaculatorMaker
- (CaculatorMaker *(^)(CGFloat))add {
    return ^CaculatorMaker * (CGFloat result) {
        _result += result;
        return self;
    };
}

- (CaculatorMaker *(^)(CGFloat))sub {
    return ^CaculatorMaker * (CGFloat result) {
        _result -= result;
        return self;
    };
}

- (CaculatorMaker *(^)(CGFloat))muilt {
    return ^CaculatorMaker *(CGFloat result) {
        _result *= result;
        return self;
    };
}

- (CaculatorMaker *(^)(CGFloat))divide {
    return ^CaculatorMaker *(CGFloat result) {
        //NSAssert(参数1, 参数2)  只要参数1 是NO 就会抛出异常  后面一句是异常的时候打印
        NSAssert(result, @"Parameter must be not zero");//为0的时候抛出异常
        _result /= result;
        return self;
    };
}

- (CaculatorMaker *)and {
    return self;
}
- (CaculatorMaker *)with {
    return self;
}
- (CGFloat)result {
    //round函数: 四舍五入的整数
    //ceil >= 一个数的整数
    //floor  <=一个数的整数
    return round(_result * 100) / 100;
}
@end
