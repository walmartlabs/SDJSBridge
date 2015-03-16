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
    @strongify(self.delegate, strongDelegate);
    
    if ([strongDelegate respondsToSelector:@selector(progressScriptShowProgressHUDWithMessage:)]) {
        [strongDelegate progressScriptShowProgressHUDWithMessage:message];
    }
}

- (void)hide {
    @strongify(self.delegate, strongDelegate);
    
    if ([strongDelegate respondsToSelector:@selector(progressScriptHideProgressHUD)]) {
        [strongDelegate progressScriptHideProgressHUD];
    }
}

#pragma mark - External API

- (void)showLoadingIndicatorWithOptions:(NSDictionary *)options {
    NSString *message = options[SDJSProgressOptionMessageKey];
    [self showWithMessage:message];
}

@end
