//
//  SDJSRegistryAPI.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/7/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSRegistryAPI.h"

#import "SDJSRegistryScannerAPI.h"

@implementation SDJSRegistryAPI

- (instancetype)initWithWebViewController:(SDWebViewController *)webViewController {
    if ((self = [super initWithWebViewController:webViewController])) {
        _scanner = [[SDJSRegistryScannerAPI alloc] initWithWebViewController:webViewController];
    }
    
    return self;
}

@end
