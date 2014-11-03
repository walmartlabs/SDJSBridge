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
@property (nonatomic, readonly) NSURL *url;
@property (nonatomic, readonly) UIWebView *webView;

- (instancetype)init;
- (instancetype)initWithURL:(NSURL *)url;
- (instancetype)initWithWebView:(UIWebView *)webView;

- (void)loadURL:(NSURL *)url;

/// @name Interacting with the JS Bridge

- (void)addScriptObject:(NSObject<JSExport> *)object name:(NSString *)name;
- (void)addScriptMethod:(NSString *)name block:(void *)block;

/// @name Navigation

- (id)pushURL:(NSURL *)url title:(NSString *)title;

#pragma mark - Subclasses should override and call super

- (void)initializeController;
- (BOOL)shouldHandleURL:(NSURL *)url;

- (void)webViewDidFinishLoad;
- (void)webViewDidStartLoad;

@end
