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
- (BOOL)webViewController:(SDWebViewController *)controller;
- (BOOL)webViewController:(SDWebViewController *)controller didCreateJavaScriptContext:(JSContext *)context;
- (BOOL)webViewControllerConfigureScriptObjects:(SDWebViewController *)controller;
@end

/**
 A view controller for loading and interacting with web view content.
 */
@interface SDWebViewController : UIViewController

@property (nonatomic, weak) id<SDWebViewControllerDelegate> delegate;
@property (nonatomic, readonly) NSURL *url;
@property (nonatomic, readonly) UIWebView *webView;

/// @name Creating Web View Controllers

- (instancetype)init;
- (instancetype)initWithURL:(NSURL *)url;
- (instancetype)initWithWebView:(UIWebView *)webView;

/// @name Initializing a Web View Controller

- (void)initializeController;

/// @name Loading URLs

- (void)loadURL:(NSURL *)url;

/// @name Navigating to URLs

- (id)pushURL:(NSURL *)url title:(NSString *)title;
- (id)presentURL:(NSURL *)url title:(NSString *)title;

/// @name Interacting with the JS Bridge

- (void)addScriptObject:(NSObject<JSExport> *)object name:(NSString *)name;
- (void)addScriptMethod:(NSString *)name block:(id)block;
- (void)configureScriptObjects;

/// @name Web View Events

- (void)webViewDidFinishLoad;
- (void)webViewDidStartLoad;
- (BOOL)shouldHandleURL:(NSURL *)url;

@end
