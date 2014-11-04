//
//  SDJSPlatformAPI.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 10/30/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSPlatformAPI.h"

#import "SDJSNavigationAPI.h"
#import "SDJSAlertAction.h"

@implementation SDJSPlatformAPI

- (instancetype)initWithWebViewController:(SDWebViewController *)webViewController {
    if ((self = [super init])) {
        _navigation = [[SDJSNavigationAPI alloc] initWithWebViewController:webViewController];
    }
    
    return self;
}

- (SDJSAlertAction *)alertActionWithTitle:(NSString *)title callback:(JSValue *)callback {
    return [SDJSAlertAction alertActionWithTitle:title callback:callback];
}

@end
