//
//  NSString+SDJSExtensions.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/18/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 A category for working with Strings that have been bridged from a JavaScript
 context.
 */
@interface NSString (SDJSExtensions)

/**
 Returns nil for "undefined" strings.
 */
- (NSString *)bridgeStringValue;

@end
