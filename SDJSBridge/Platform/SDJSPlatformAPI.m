//
//  SDJSPlatformAPI.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 10/30/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSPlatformAPI.h"
#import "SDJSNavigationAPI.h"

@implementation SDJSPlatformAPI

- (instancetype)initWithWebViewController:(SDWebViewController *)webViewController {
    if ((self = [super init])) {
        _navigation = [[SDJSNavigationAPI alloc] initWithWebViewController:webViewController];
    }
    
    return self;
}

@end
