//
//  HJWeakScriptMessageDelegate.m
//  DevoutCat
//
//  Created by apple on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HJWeakScriptMessageDelegate.h"

@implementation HJWeakScriptMessageDelegate
- (void)dealloc {
    XHJLog(@"%@释放了", self.class);
}
- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if (self.scriptDelegate && [self.scriptDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];        
    }
}
@end
