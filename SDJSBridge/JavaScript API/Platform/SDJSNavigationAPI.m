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

@implementation SDJSNavigationAPI
{
    NSString *_currentURL;
}

- (instancetype)initWithWebViewController:(SDWebViewController *)webViewController {
    self = [super initWithWebViewController:webViewController];
    
    if (self) {
        _navigationBar = [[SDJSNavigationBarAPI alloc] initWithWebViewController:self.webViewController];
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
    [self.webViewController pushURL:url title:title];
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
    [self.webViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
