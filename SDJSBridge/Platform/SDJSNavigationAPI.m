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

@property (nonatomic, weak) UINavigationController *navigationController;
@property (nonatomic, weak) UIWebView *webView;

@end

@implementation SDJSNavigationAPI
{
    NSString *_currentURL;
}

#pragma mark - Initialization

- (instancetype)initWithWebView:(UIWebView *)webView navigationController:(UINavigationController *)navigationController {
    if ((self = [super init])) {
        _webView = webView;
        _navigationController = navigationController;
    }
    
    return self;
}

#pragma mark - SDWebViewController

- (SDWebViewController *)webViewControllerWithURL:(NSURL *)url title:(NSString *)title {
    SDWebViewController *webViewController = [[SDWebViewController alloc] initWithWebView:self.webView];
    webViewController.title = title;
    return webViewController;
}

#pragma mark - Push/Pop

- (void)pushURL:(NSString *)urlString title:(NSString *)title {
    
    if (urlString.length == 0 || [urlString isEqualToString:_currentURL]) {
        return;
    }
    
    _currentURL = urlString;
    
    NSURL *url = [NSURL URLWithString:urlString];
    if (!url.scheme)
    {
        NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:urlString withExtension:nil];
        url = bundleURL;
    }
    
    
    SDWebViewController *webViewController = [self webViewControllerWithURL:url title:title];
    [self.navigationController pushViewController:webViewController animated:YES];
    [webViewController loadURL:url];
}

- (void)popURL {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Modals

- (void)presentModalURL:(NSString *)urlString title:(NSString *)title {
    NSURL *url = [NSURL URLWithString:urlString];
    SDWebViewController *webViewController = [self webViewControllerWithURL:url title:title];
    [self.navigationController.topViewController presentViewController:webViewController animated:YES completion:nil];
    [webViewController loadURL:url];
}

- (void)dismissModalURL {
    [self.navigationController.topViewController.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
