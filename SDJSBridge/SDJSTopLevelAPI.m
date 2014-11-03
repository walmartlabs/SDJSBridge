//
//  SDJSTopLevelAPI.m
//  SDJSBridge
//
//  Created by Brandon Sneed on 9/22/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSTopLevelAPI.h"

#import "SDWebViewController.h"

NSString * const SDJSTopLevelAPIScriptName = @"JSBridgeAPI";

@implementation SDJSTopLevelAPI

#pragma mark - Initialization

- (instancetype)initWithWebViewController:(SDWebViewController *)webViewController {
    if ((self = [super init])) {
        _platform = [[SDJSPlatformAPI alloc] initWithWebViewController:webViewController];
    }
    
    return self;
}

@end
