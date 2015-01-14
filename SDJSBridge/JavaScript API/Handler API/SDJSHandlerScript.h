//
//  SDJSHandlerScript.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/18/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"

#import <JavaScriptCore/JavaScriptCore.h>

extern NSString * const SDJSHandlerScriptName;

typedef void (^SDBridgeHandlerOutputBlock)(id data);
typedef void (^SDBridgeHandlerBlock)(id data, SDBridgeHandlerOutputBlock callback);

/**
 JavaScript exports for handler API.
 */
@protocol SDJSHandlerScriptExports <JSExport>

JSExportAs(callHandler, - (void)callHandlerWithName:(NSString *)handlerName data:(JSValue *)data callback:(JSValue *)callback);
JSExportAs(registerHandler, - (void)registerHandlerWithName:(NSString *)handlerName jsHandler:(JSValue *)jsHandler);

@end

/**
 Provides a JavaScript bridge API for registing and calling handlers.
 */
@interface SDJSHandlerScript : SDJSBridgeScript <SDJSHandlerScriptExports>

/// @name Handler API

/**
 Register a JavaScript handler.
 @param handlerName Name of handler.
 @param handler Block to execute when the handler is called.
 */
- (void)registerHandlerWithName:(NSString *)handlerName handler:(SDBridgeHandlerBlock)handler;

/**
 Call a JavaScript handler.
 @param handlerName Name of handler.
 @param data Parameter data for handler.
 @param outputBlock Block to execute when the handler is finished executing. The data parameter of
 the output block gets sent back to JavaScript as part of the handler callback.
 */
- (void)callHandlerWithName:(NSString *)handlerName data:(id)data outputBlock:(SDBridgeHandlerOutputBlock)outputBlock;

- (void)callHandlerWithName:(NSString *)handlerName data:(id)data;

@end
