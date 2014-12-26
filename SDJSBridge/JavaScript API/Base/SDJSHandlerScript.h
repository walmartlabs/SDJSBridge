//
//  SDJSHandlerScript.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/18/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"

#import <JavaScriptCore/JavaScriptCore.h>

typedef void (^SDBridgeHandlerCallbackBlock)(id data);
typedef void (^SDBridgeHandlerBlock)(JSValue *data, SDBridgeHandlerCallbackBlock callback);

@protocol SDJSBridgeHandler <NSObject>

- (NSString *)handlerName;
- (void)callHandlerWithData:(JSValue *)data callback:(SDBridgeHandlerCallbackBlock)callback;

@end


@protocol SDJSBridgeScriptExports <JSExport>

JSExportAs(callHandler, - (void)callHandlerWithName:(NSString *)handlerName data:(JSValue *)data callback:(JSValue *)callback);

@end


@interface SDJSHandlerScript : SDJSBridgeScript <SDJSBridgeScriptExports>

- (void)registerHandlerWithName:(NSString *)handlerName handler:(SDBridgeHandlerBlock)handler;
- (void)callHandlerWithName:(NSString *)handlerName data:(JSValue *)data callback:(JSValue *)callback;

@end
