//
//  SDJSTopLevelAPI.m
//  SDJSBridge
//
//  Created by Brandon Sneed on 9/22/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSTopLevelAPI.h"

#import "SDWebViewController.h"
#import "SDJSAlertScript.h"
#import "SDJSNavigationScript.h"
#import "SDJSProgressHUDScript.h"

NSString * const SDJSTopLevelAPIScriptName = @"JSBridgeAPI";

@interface SDJSTopLevelAPI ()

@property (nonatomic, strong) SDJSAlertScript *alertScript;
@property (nonatomic, strong) SDJSNavigationScript *navigationScript;

@end

@implementation SDJSTopLevelAPI

#pragma mark - Web View Controller

- (void)setWebViewController:(SDWebViewController *)webViewController {
    [super setWebViewController:webViewController];
    _alertScript.webViewController = webViewController;
}

#pragma mark - Logging API

- (void)logValue:(JSValue *)value {
    NSLog(@"SDJSTopLevelAPI: %@", value);
}

#pragma mark - Bridge Callback Block

- (SDBridgeHandlerCallbackBlock)handlerBlockWithCallback:(JSValue *)callback {
    return ^(id outputData) {
        NSArray *arguments = outputData == nil ? nil : @[outputData];
        [callback callWithArguments:arguments];
    };
}

#pragma mark - Alert

- (SDJSAlertScript *)alertScript {
    if (!_alertScript) {
        _alertScript = [[SDJSAlertScript alloc] initWithWebViewController:self.webViewController];
    }
    
    return _alertScript;
}

- (void)showAlertWithOptions:(NSDictionary *)options callback:(JSValue *)callback {
    [self.alertScript showAlertWithOptions:options callback:[self handlerBlockWithCallback:callback]];
}

#pragma mark - Navigation

- (SDJSNavigationScript *)navigationScript {
    if (!_navigationScript) {
        _navigationScript = [[SDJSNavigationScript alloc] initWithWebViewController:self.webViewController];
    }
    
    return _navigationScript;
}

- (void)pushStateWithOptions:(NSDictionary *)options {
    [self.navigationScript pushStateWithOptions:options];
}

- (void)replaceStateWithOptions:(NSDictionary *)options {
    [self.navigationScript replaceStateWithOptions:options];

}

#pragma mark - Loading Indicator

- (SDJSProgressHUDScript *)progressScript {
    if (!_progressScript) {
        _progressScript = [[SDJSProgressHUDScript alloc] initWithWebViewController:self.webViewController];
    }
    
    return _progressScript;
}

- (void)showLoadingIndicatorWithOptions:(NSDictionary *)options {
    [self.progressScript showLoadingIndicatorWithOptions:options];
}

- (void)hideLoadingIndicator {
    [self.progressScript hide];
}

@end
