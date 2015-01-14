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

#pragma mark - Bridge Callback Block

- (SDBridgeHandlerOutputBlock)handlerBlockWithCallback:(JSValue *)callback {
    return ^(id outputData) {
        NSArray *arguments = outputData == nil ? nil : @[outputData];
        [callback callWithArguments:arguments];
    };
}

#pragma mark - Handler API

- (void)registerHandlerWithName:(NSString *)handlerName handler:(SDBridgeHandlerBlock)handler {
    if (!self.handlers) {
        self.handlers = [[NSMutableDictionary alloc] init];
    }
    
    self.handlers[handlerName] = [handler copy];
}

- (void)callHandlerWithName:(NSString *)handlerName data:(id)data outputBlock:(SDBridgeHandlerOutputBlock)outputBlock {
    SDBridgeHandlerBlock handler = self.handlers[handlerName];
    
    if (handler) {
        handler(data, outputBlock);
    }
}

#pragma mark - SDJSHandlerScriptExports

- (void)callHandlerWithName:(NSString *)handlerName data:(JSValue *)data callback:(JSValue *)callback {
    [self callHandlerWithName:handlerName data:[data toObject] outputBlock:^(id outputData) {
        NSArray *arguments = outputData == nil ? nil : @[outputData];
        [callback callWithArguments:arguments];
    }];
}

- (void)registerHandlerWithName:(NSString *)handlerName jsHandler:(JSValue *)jsHandler {
    [self registerHandlerWithName:handlerName handler:^(id data, SDBridgeHandlerOutputBlock callback) {
        [jsHandler callWithArguments:@[data]];
    }];
}

@end
