//
//  SDWebViewController.h
//  SDJSBridgeExample
//
//  Created by Brandon Sneed on 10/9/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@class SDWebViewController;

@protocol SDWebViewControllerDelegate <NSObject>
- (BOOL)webViewController:(SDWebViewController *)controller shouldOpenRequest:(NSURLRequest *)request;
- (BOOL)webViewControllerDidStartLoad:(SDWebViewController *)controller;
- (BOOL)webViewControllerDidFinishLoad:(SDWebViewController *)controller;
@end



@interface SDWebViewController : UIViewController

@property (nonatomic, weak) id<SDWebViewControllerDelegate> delegate;

- (instancetype)init;
- (instancetype)initWithWebView:(UIWebView *)webView;

- (void)loadURL:(NSURL *)url;

- (void)addScriptObject:(NSObject<JSExport> *)object name:(NSString *)name;
- (void)addScriptMethod:(NSString *)name block:(void *)block;

@end
