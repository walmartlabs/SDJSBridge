//
//  SDJSBridge.h
//  SDJSBridgeExample
//
//  Created by Brandon Sneed on 10/9/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface SDJSBridge: NSObject

- (instancetype)init;
- (instancetype)initWithWebView:(UIWebView *)webView;

- (void)configureContext:(JSContext *)context;

- (void)addScriptObject:(NSObject<JSExport> *)object name:(NSString *)name;
- (void)addScriptMethod:(NSString *)name block:(void *)block;

- (JSValue *)evaluateScript:(NSString *)script;

@end
