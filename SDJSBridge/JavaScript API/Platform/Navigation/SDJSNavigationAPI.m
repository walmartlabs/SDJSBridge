//
//  SDJSNavigationAPI.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 10/30/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSNavigationAPI.h"
#import "SDWebViewController.h"
#import "SDJSPlatformAPI.h"
#import "SDJSNavigationBarAPI.h"
#import "SDJSNavigationItem.h"

@implementation SDJSNavigationAPI

#pragma mark - Accessors

- (void)setWebViewController:(SDWebViewController *)webViewController {
    [super setWebViewController:webViewController];
    _navigationBarScript.webViewController = webViewController;
}

#pragma mark - Initialization

- (instancetype)initWithWebViewController:(SDWebViewController *)webViewController {
    self = [super initWithWebViewController:webViewController];
    
    if (self) {
        _navigationBarScript = [[SDJSNavigationBarAPI alloc] initWithWebViewController:self.webViewController];
    }
    
    return self;
}

#pragma mark - SDJSNavigationAPIExports

- (SDJSNavigationBarAPI *)navigationBar {
    return _navigationBarScript;
}

#pragma mark - URL Construction

- (NSURL *)URLWithURLString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    if (!url.scheme)
    {
        NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:urlString withExtension:nil];
        url = bundleURL;
    }
    
    return url;
}

#pragma mark - Push/Pop

- (void)pushUrl:(NSString *)urlString title:(NSString *)title {
    NSURL *url = [self URLWithURLString:urlString];
    [self.webViewController pushURL:url title:title];
}                                                                                                                                         

- (void)popUrl {
    [self.webViewController.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Modals

- (void)presentModalUrl:(NSString *)urlString title:(NSString *)title {
    NSURL *url = [self URLWithURLString:urlString];
    [self.webViewController presentURL:url title:title];
}

- (void)dismissModalUrl {
    [self.webViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - SDJSNavigationItem

- (SDJSNavigationItem *)navigationItemWithTitle:(NSString *)title imageName:(NSString *)imageName callback:(JSValue *)callback {
    return [SDJSNavigationItem navigationItemWithTitle:title imageName:imageName callback:callback];
}

@end
