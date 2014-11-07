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

/**
 A concrete class that provides access to a UIWebView's JavaScript context 
 object. Provides methods to adding scripts and retreiving values out of the 
 JavaScript context.
 */
@interface SDJSBridge: NSObject

/// @name Intializing a Bridge

- (instancetype)init;
- (instancetype)initWithWebView:(UIWebView *)webView;

/// @name Configuring

- (void)configureContext:(JSContext *)context;

/// @name Adding JS Script Objects

- (void)addScriptObject:(NSObject<JSExport> *)object name:(NSString *)name;

/// @name Adding Blocks

- (void)addScriptMethod:(NSString *)name block:(id)block;

/// @name Running Script Strings

- (JSValue *)evaluateScript:(NSString *)script;

/// @name Retrieving JS Values

- (JSValue *)scriptValueForName:(NSString *)name;

@end
