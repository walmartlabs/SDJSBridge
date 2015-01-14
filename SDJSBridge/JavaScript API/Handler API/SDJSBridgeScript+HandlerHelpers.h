//
//  SDJSBridgeScript+HandlerHelpers.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/14/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"
#import "SDJSHandlerScript.h"

@interface SDJSBridgeScript (HandlerHelpers)

+ (SDBridgeHandlerOutputBlock)handlerOutputBlockWithCallback:(JSValue *)callback;

@end
