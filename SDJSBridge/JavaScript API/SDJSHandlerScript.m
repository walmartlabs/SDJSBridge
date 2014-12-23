//
//  SDJSHandlerScript.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/18/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSHandlerScript.h"

@interface SDJSHandlerScript ()

@property (nonatomic, strong) NSMutableDictionary *handlers;

@end

@implementation SDJSHandlerScript

#pragma mark -

- (void)registerHandlerWithName:(NSString *)handlerName handler:(SDBridgeHandlerBlock)handler {
    if (!self.handlers) {
        self.handlers = [[NSMutableDictionary alloc] init];
    }
    
    self.handlers[handlerName] = [handler copy];
}

- (void)callHandlerWithName:(NSString *)handlerName data:(JSValue *)data callback:(JSValue *)callback {
    SDBridgeHandlerBlock handler = self.handlers[handlerName];
    
    SDBridgeHandlerCallbackBlock callbackBlock = ^(id outputData) {
        NSArray *arguments = outputData == nil ? nil : @[outputData];
        [callback callWithArguments:arguments];
    };
    
    handler(data, callbackBlock);
}

@end
