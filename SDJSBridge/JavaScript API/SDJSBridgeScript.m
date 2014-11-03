//
//  SDJSBridgeScript.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/3/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"

#import "SDWebViewController.h"

@interface SDJSBridgeScript ()

@property (nonatomic, weak, readwrite) SDWebViewController *webViewController;

@end

@implementation SDJSBridgeScript

- (instancetype)initWithWebViewController:(SDWebViewController *)webViewController {
    if ((self = [super init])) {
        _webViewController = webViewController;
    }
    
    return self;
}

@end
