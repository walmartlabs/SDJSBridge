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
 
 ## Usage

 Create a new bridge.

     UIWebView *webView;   
     SDJSBridge *bridge = [[SDJSBridge alloc] initWithWebView:webView];

 Add scripts to the JavaScript context.

     SDJSTopLevelAPI *apiScript = [[SDJSTopLevelAPI alloc] initWithWebViewController:self];
     [bridge addScriptObject:apiScript name:@"JSBridgeAPI"];

 Retrieving scripts from the JavaScript context.

     JSValue *scriptValue = [bridge scriptValueForName:@"JSBridgeAPI"];

 Evaluating scripts in the JavaScript context.

     JSValue *scriptValue [bridge evaluateScript:@"function () {return 'hello world'}"];
     NSLog(@"%@", scriptValue); // "hello world"

 */
@interface SDJSBridge: NSObject

/// @name Intializing a Bridge

/**
 Initialize a SDJSBridge. Creates a new JSContext.
 */
- (instancetype)init;

/**
 Intialize a SDJSBridge with a web view. Extracts the web view's JSContext 
 @param webView Web view used to reference the JSContext.
 via KVO.
 */
- (instancetype)initWithWebView:(UIWebView *)webView;

/// @name Configuring

- (void)configureContext:(JSContext *)context;

/// @name Adding JS Script Objects

/**
 Add a script object to the bridge's JavaScript context.
 @param object bridge script object to be added.
 @param name Name of the object in context.
 */
- (void)addScriptObject:(NSObject<JSExport> *)object name:(NSString *)name;

/// @name Adding Blocks

/**
 Add a block as a JavaScript function to the bridge's JavaScript context.
 @param name Name of the function in the context.
 @param block Objective-C block to add to the JavaScript context as a function.
 */
- (void)addScriptMethod:(NSString *)name block:(id)block;

/// @name Running Script Strings

/**
 Evaluates a JavaScript string in the JavaScript context.
 @param script JavaScript string to run in the context.
 @return The result of evaluating the script.
 */
- (JSValue *)evaluateScript:(NSString *)script;

/// @name Retrieving JS Values

/**
 Retrieve script values by name out of the JavaScript context.
 @param name Name of the JavaScript value to return.
 @return The script value.
 */
- (JSValue *)scriptValueForName:(NSString *)name;

@end
