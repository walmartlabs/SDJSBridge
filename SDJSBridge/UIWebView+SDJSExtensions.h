//
//  UIWebView+SDJSExtensions.h
//  SDJSBridgeExample
//
//  Created by Brandon Sneed on 10/9/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//
//  Based on UIWebView+TS_JavaScriptContext by Nicholas Hodapp
//  Copyright (c) 2013 CoDeveloper, LLC.

#import <UIKit/UIKit.h>

#import <JavaScriptCore/JavaScriptCore.h>

@protocol SDJSWebViewDelegate <UIWebViewDelegate>
@optional
- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext*) ctx;
@end


@interface UIWebView(SDJSExtensions)
@property (nonatomic, readonly) JSContext* sdjs_context;
@end
