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

@interface SDJSNavigationAPI ()

@property (nonatomic, weak) SDWebViewController *webViewController;

@end

@implementation SDJSNavigationAPI
{
    NSString *_currentURL;
}

#pragma mark - Initialization

- (instancetype)initWithWebViewController:(SDWebViewController *)webViewController {
    if ((self = [super init])) {
        _webViewController = webViewController;
    }
    
    return self;
}

#pragma mark - URLs

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

- (void)pushURL:(NSString *)urlString title:(NSString *)title {
    
    if (urlString.length == 0 || [urlString isEqualToString:_currentURL]) {
        return;
    }
    
    _currentURL = urlString;
    
    NSURL *url = [self URLWithURLString:urlString];
    id currentWebController = [self.webViewController pushURL:url title:title];
    self.webViewController = currentWebController;
}

- (void)popURL {
    [self.webViewController.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Modals

- (void)presentModalURL:(NSString *)urlString title:(NSString *)title {
    NSURL *url = [self URLWithURLString:urlString];
    [self.webViewController presentURL:url title:title];
}

- (void)dismissModalURL {
    [self.webViewController.navigationController.topViewController.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
