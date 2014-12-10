//
//  SDJSProgressAPI.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/6/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSProgressAPI.h"
#import "SDMacros.h"

@implementation SDJSProgressAPI

- (void)showWithMessage:(NSString *)message {
    // possibly support built-in HUD instead of delegating?
    @strongify(self.delegate, strongDelegate);
    
    if ([strongDelegate respondsToSelector:@selector(showProgressHUDWithMessage:)]) {
        [strongDelegate showProgressHUDWithMessage:message];
    }
}

- (void)hide {
    @strongify(self.delegate, strongDelegate);
    
    if ([strongDelegate respondsToSelector:@selector(hideProgressHUD)]) {
        [strongDelegate hideProgressHUD];
    }
}

@end
