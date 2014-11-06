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

/// @name Intializing a Bridge

- (instancetype)init;
- (instancetype)initWithWebView:(UIWebView *)webView;

/// @name Configuring

- (void)configureContext:(JSContext *)context;

/// @name Adding JS Script Objects

- (void)addScriptObject:(NSObject<JSExport> *)object name:(NSString *)name;
- (void)addScriptMethod:(NSString *)name block:(void *)block;

/// @name Running Script Strings

- (JSValue *)evaluateScript:(NSString *)script;

/// @name Retrieving JS Values

- (JSValue *)scriptValueForName:(NSString *)name;

@end
