//
//  SDJSHandlerScript.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/18/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import <IOSShared/IOSShared.h>
#import "SDJSHandlerScript.h"
#import "SDJSBridgeScript+HandlerHelpers.h"

@interface SDJSHandlerScript ()

@property (nonatomic, strong) NSMutableDictionary *handlers;

@end

@implementation SDJSHandlerScript

#pragma mark - Handler API

- (void)registerHandlerWithName:(NSString *)handlerName handler:(SDBridgeHandlerBlock)handler {
    if (!self.handlers) {
        self.handlers = [[NSMutableDictionary alloc] init];
    }
    
    self.handlers[handlerName] = [handler copy];
}

- (void)callHandlerWithName:(NSString *)handlerName data:(id)data {
    [self callHandlerWithName:handlerName data:data outputBlock:nil];
}

- (void)callHandlerWithName:(NSString *)handlerName data:(id)data outputBlock:(SDBridgeHandlerOutputBlock)outputBlock {
    SDBridgeHandlerBlock handler = self.handlers[handlerName];
    
    if (handler) {
        handler(data, outputBlock);
    }
}

#pragma mark - SDJSHandlerScriptExports

- (void)callHandlerWithName:(NSString *)handlerName data:(JSValue *)data callback:(JSValue *)callback {
    @weakify(self);
    
    [self callHandlerWithName:handlerName data:[data toObject] outputBlock:^(id outputData) {
        @strongify(self);
        [callback callWithArguments:[self argumentsWithOutputData:data]];
    }];
}

- (void)registerHandlerWithName:(NSString *)handlerName jsHandler:(JSValue *)jsHandler {
    @weakify(self);
    
    [self registerHandlerWithName:handlerName handler:^(id data, SDBridgeHandlerOutputBlock callback) {
        @strongify(self);
        [jsHandler callWithArguments:[self argumentsWithOutputData:data]];
    }];
}

#pragma mark - Helpers

- (NSArray *)argumentsWithOutputData:(id)outputData {
    return outputData == nil ? nil : @[outputData];
}

@end
