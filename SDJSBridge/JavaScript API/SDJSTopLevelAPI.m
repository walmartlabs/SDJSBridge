//
//  SDJSTopLevelAPI.m
//  SDJSBridge
//
//  Created by Brandon Sneed on 9/22/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSTopLevelAPI.h"

#import "SDWebViewController.h"
#import "SDJSPlatformAPI.h"
#import "SDJSAlertScript.h"
#import "SDJSNavigationScript.h"

NSString * const SDJSTopLevelAPIScriptName = @"JSBridgeAPI";

@interface SDJSTopLevelAPI ()

@property (nonatomic, strong) SDJSAlertScript *alertScript;
@property (nonatomic, strong) SDJSNavigationScript *navigationScript;

@end

@implementation SDJSTopLevelAPI

#pragma mark - Accessors

- (void)setWebViewController:(SDWebViewController *)webViewController {
    [super setWebViewController:webViewController];
    _platformScript.webViewController = webViewController;
    _alertScript.webViewController = webViewController;
}

#pragma mark - Initialization

- (instancetype)initWithWebViewController:(SDWebViewController *)webViewController {
    if ((self = [super initWithWebViewController:webViewController])) {
        _platformScript = [[SDJSPlatformAPI alloc] initWithWebViewController:webViewController];
    }
    
    return self;
}

#pragma mark - Logging API

- (void)logValue:(JSValue *)value {
    NSLog(@"SDJSTopLevelAPI: %@", value);
}

#pragma mark - SDJSTopLevelAPIExports

- (SDJSPlatformAPI *)platform {
    return _platformScript;
}

#pragma mark - Bridge Callback Block

- (SDBridgeHandlerCallbackBlock)handlerBlockWithCallback:(JSValue *)callback {
    return ^(id outputData) {
        NSArray *arguments = outputData == nil ? nil : @[outputData];
        [callback callWithArguments:arguments];
    };
}

#pragma mark - Alert Script

- (SDJSAlertScript *)alertScript {
    if (!_alertScript) {
        _alertScript = [[SDJSAlertScript alloc] initWithWebViewController:self.webViewController];
    }
    
    return _alertScript;
}

#pragma mark - Alert Exports

- (void)showAlertWithOptions:(NSDictionary *)options callback:(JSValue *)callback {
    [self.alertScript showAlertWithOptions:options callback:[self handlerBlockWithCallback:callback]];
}

#pragma mark - Navigation Script

- (SDJSNavigationScript *)navigationScript {
    if (!_navigationScript) {
        _navigationScript = [[SDJSNavigationScript alloc] initWithWebViewController:self.webViewController];
    }
    
    return _navigationScript;
}


#pragma mark - Navigatino Exports

- (void)pushStateWithOptions:(NSDictionary *)options {
    [self.navigationScript pushStateWithOptions:options];
}

- (void)replaceStateWithOptions:(NSDictionary *)options {
    [self.navigationScript replaceStateWithOptions:options];

}

@end
