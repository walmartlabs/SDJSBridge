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

NSString * const SDJSTopLevelAPIScriptName = @"JSBridgeAPI";

@implementation SDJSTopLevelAPI

#pragma mark - Accessors

- (void)setWebViewController:(SDWebViewController *)webViewController {
    [super setWebViewController:webViewController];
    _platformScript.webViewController = webViewController;
}

- (instancetype)initWithWebViewController:(SDWebViewController *)webViewController {
    if ((self = [super initWithWebViewController:webViewController])) {
        _platformScript = [[SDJSPlatformAPI alloc] initWithWebViewController:webViewController];
    }
    
    return self;
}

- (void)logValue:(JSValue *)value {
    NSLog(@"SDJSTopLevelAPI: %@", value);
}

#pragma mark - SDJSTopLevelAPIExports

- (SDJSPlatformAPI *)platform {
    return _platformScript;
}

@end
