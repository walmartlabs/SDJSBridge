//
//  SDJSNavigationScript.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/22/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSNavigationScript.h"
#import "SDJSHandlerScript.h"
#import "SDWebViewController.h"

NSString * const SDJSNavigationScriptTitleKey = @"title";
NSString * const SDJSNavigationScriptBackTitleKey = @"backTitle";
NSString * const SDJSNavigationScriptURLKey = @"url";

@implementation SDJSNavigationScript

#pragma mark - URL Construction

- (NSURL *)URLWithURLString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    
    if (!url.scheme) {
        NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:urlString withExtension:nil];
        url = bundleURL;
    }
    
    return url;
}

#pragma mark - Navigation

- (id)pushURL:(NSString *)urlString title:(NSString *)title backTitle:(NSString *)backTitle {
    NSURL *url = [self URLWithURLString:urlString];
    return [self.webViewController pushURL:url title:title];
}

- (void)loadURL:(NSString *)urlString title:(NSString *)title backTitle:(NSString *)backTitle {
    NSURL *url = [self URLWithURLString:urlString];
    [self.webViewController loadURL:url];
}


#pragma mark - External API

- (void)pushStateWithOptions:(NSDictionary *)options {
    NSString *title = options[SDJSNavigationScriptTitleKey];
    NSString *backTitle = options[SDJSNavigationScriptBackTitleKey];
    NSString *urlString = options[SDJSNavigationScriptURLKey];
    
    [self pushURL:urlString title:title backTitle:backTitle];
}

- (void)replaceStateWithOptions:(NSDictionary *)options {
    NSString *title = options[SDJSNavigationScriptTitleKey];
    NSString *backTitle = options[SDJSNavigationScriptBackTitleKey];
    NSString *urlString = options[SDJSNavigationScriptURLKey];
    
    [self loadURL:urlString title:title backTitle:backTitle];
}

@end
