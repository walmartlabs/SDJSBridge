//
//  SDJSProgressHUDScript.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/6/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSProgressHUDScript.h"
#import "SDMacros.h"

NSString * const SDJSProgressOptionMessageKey = @"message";

@implementation SDJSProgressHUDScript

- (void)showWithMessage:(NSString *)message {
    // possibly support built-in HUD instead of delegating?
    @strongify(self.delegate, strongDelegate);
    
    if ([strongDelegate respondsToSelector:@selector(showProgressHUDWithMessage:)]) {
        [strongDelegate showProgressHUDWithMessage:message];
    }
}

- (void)hide {
    NSLog(@"hide");

    @strongify(self.delegate, strongDelegate);
    
    if ([strongDelegate respondsToSelector:@selector(hideProgressHUD)]) {
        [strongDelegate hideProgressHUD];
    }
}

#pragma mark - External API

- (void)showLoadingIndicatorWithOptions:(NSDictionary *)options {
    NSString *message = options[SDJSProgressOptionMessageKey];
    [self showWithMessage:message];
}

@end
