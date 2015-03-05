//
//  NSDictionary+SDJSExtensions.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 3/5/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import "NSDictionary+SDJSExtensions.h"

@implementation NSDictionary (SDJSExtensions)

- (NSDictionary *)validBridgeScriptOptions {
    NSMutableDictionary *validOptions = [NSMutableDictionary dictionary];
    
    for (NSString *key in self) {
        id value = self[key];
        
        if (![value isKindOfClass:[NSNull class]]) {
            validOptions[key] = value;
        }
    }
    
    return [validOptions copy];
}

@end
