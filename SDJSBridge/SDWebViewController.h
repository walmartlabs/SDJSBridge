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

/**
 A protocol for handling SDWebViewController events.
 */
@protocol SDWebViewControllerDelegate <NSObject>

/**
 Return `NO` to force the web view controller to open the request in the
 standard web navigation system.
 the standard web navigation system.
 @param controller The web view controller that is attempting to open the request.
 @param request The request that is to be opened.
 */
- (BOOL)webViewController:(SDWebViewController *)controller shouldOpenRequest:(NSURLRequest *)request;

/**
 Sent after the web view starts loading.
 @param controller The web view controller containing the web view that has
 started loading.
 */
- (void)webViewControllerDidStartLoad:(SDWebViewController *)controller;

/**
 Sent after the web view has finished loading.
 @param controller The web view controller containing the web view that has
 finished loading.
 */
- (void)webViewControllerDidFinishLoad:(SDWebViewController *)controller;

/**
 Sent after the web view has created a JavaScript context.
 @param controller The web view controller containing the web view that has
 finished loading.
 */
- (void)webViewController:(SDWebViewController *)controller didCreateJavaScriptContext:(JSContext *)context;

/**
 Sent when the web view controller is adding script objects to the JavaScript
 context.
 @param controller The web view controller.
 finished loading.
 */
- (void)webViewControllerConfigureScriptObjects:(SDWebViewController *)controller;

@end

/**
 A view controller class for loading and interacting with web view content.
 
 ## Usage
 
 Creating a web view controller and loading a URL.
 
     NSURL *url;
     SDWebViewController *webViewController = [[SDWebViewController alloc] init];
     [webViewController loadURL:url];
 
 ### Navigation
 
 Push a new web view controller on to the navigation stack and load the URL.
 
     NSURL *nextPageURL;
     [webViewController pushURL:nextPageURL title:nil]
    
 Present a modal new web view controller and load the URL.

     NSURL *modalURL;
     [webViewController presentURL:modalURL title:nil]

 */
@interface SDWebViewController : UIViewController

/**
 Web view controller delegate.
 */
@property (nonatomic, weak) id<SDWebViewControllerDelegate> delegate;

/**
 URL of the request to load in the web view.
 */
@property (nonatomic, readonly) NSURL *url;

/**
 Web view used to load the URL requests.
 */
@property (nonatomic, readonly) UIWebView *webView;

/// @name Creating Web View Controllers

/**
 Initialize a web view controller.
 */
- (instancetype)init;

/**
 Initialize a web view controller with a URL.
 */
- (instancetype)initWithURL:(NSURL *)url;

/**
 Initialize a web view controller with a web view.
 */
- (instancetype)initWithWebView:(UIWebView *)webView;

/// @name Initializing a Web View Controller

/**
 Override to customize initialization.
 */
- (void)initializeController;

/// @name Loading URLs

/**
 Load the web view with a specific URL.
 @param url URL of the request to load in the web view.
 */
- (void)loadURL:(NSURL *)url;

/// @name Navigating to URLs

/**
 Push a new web view controller on the navigation stack that loads the provided
 URL.
 @param url URL of the request to load in the web view.
 @param title Title of the web view controller. Set as the view controller's 
 title property.
 */
- (id)pushURL:(NSURL *)url title:(NSString *)title;

/**
 Present a new modal web view controller that loads the provided URL.
 @param url URL of the request to load in the web view.
 @param title Title of the web view controller. Set as the view controller's
 title property.
 */
- (id)presentURL:(NSURL *)url title:(NSString *)title;

/// @name Interacting with the JS Bridge

/**
 @param object Script object to add to the web view's JavaScript context.
 @param name Name of the script object.
 */
- (void)addScriptObject:(NSObject<JSExport> *)object name:(NSString *)name;

/**
 @param name Name of the JavaScript function.
 @param block Objective-C block that is added to the JavaScript context as a 
 function.
 */
- (void)addScriptMethod:(NSString *)name block:(id)block;
- (void)configureScriptObjects;

/// @name Web View Events

/**
 Called when the web view has finished loading.
 */
- (void)webViewDidFinishLoad;

/**
 Called when the web view starts loading.
 */
- (void)webViewDidStartLoad;

/**
 Return `NO` to handle force the web view controller to handle the click though
 the standard web navigation system. Default implementation returns `YES` to 
 push new web view controllers on the navigation stack that load the uRL.
 in a subclass.
 */
- (BOOL)shouldHandleURL:(NSURL *)url;

@end
