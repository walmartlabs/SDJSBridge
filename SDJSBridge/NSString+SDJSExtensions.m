//
//  NSString+SDJSExtensions.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/18/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "NSString+SDJSExtensions.h"

NSString * const SDJSBridgeValueUndefined = @"undefined";

@implementation NSString (SDJSExtensions)

- (NSString *)bridgeStringValue {
    // undefined parameters in JavaScript are passed to Obj-C as @"undefined"
    return [self isEqualToString:SDJSBridgeValueUndefined] ? nil : self;
}

@end
