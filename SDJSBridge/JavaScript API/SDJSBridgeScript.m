//
//  SDJSBridgeScript.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/3/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"

#import "SDWebViewController.h"

@implementation SDJSBridgeScript

#pragma mark - Initialization

- (instancetype)initWithWebViewController:(SDWebViewController *)webViewController {
    if ((self = [super init])) {
        _webViewController = webViewController;
    }
    
    return self;
}

@end
