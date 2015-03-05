//
//  NSDictionary+SDJSExtensions.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 3/5/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SDJSExtensions)


/// @name Validating Bridge Script Input

/**
 Returns a copy of the dictionary that only contains valid bridge script values.
 Currently this method only strips NSNull values.
 */
- (NSDictionary *)validBridgeScriptOptions;

@end
