//
//  SDJSBridgeScript+HandlerHelpers.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/14/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript+HandlerHelpers.h"

#import "SDJSHandlerScript.h"

@implementation SDJSBridgeScript (HandlerHelpers)

+ (SDBridgeHandlerOutputBlock)handlerOutputBlockWithCallback:(JSValue *)callback {
    return ^(id outputData) {
        NSArray *arguments = outputData == nil ? nil : @[outputData];
        [callback callWithArguments:arguments];
    };
}

@end
