//
//  SDJSTopLevelAPI.h
//  SDJSBridge
//
//  Created by Brandon Sneed on 9/22/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@class SDJSPlatformAPI;

extern NSString * const SDJSTopLevelAPIScriptName;

/**
 A protocol that describes how the top level API is exported to JavaScript.
 */
@protocol SDJSTopLevelAPIExports <JSExport>

/// @name JavaScript API

/**
 Platform API object.
 */
- (SDJSPlatformAPI *)platform;

/**
 Log JavaScript values in Objective-C
 */
JSExportAs(log, - (void)logValue:(JSValue *)value);

@end

/**
 A JavaScript bridge for interacting with the top level of the SDJSBridgeAPI.
 */
@interface SDJSTopLevelAPI : SDJSBridgeScript<SDJSTopLevelAPIExports>

/**
 Platform API script that provides the platform API bridge.
 */
@property (nonatomic, strong) SDJSPlatformAPI *platformScript;

/// @name Logging JavaScript Values

/**
 Log a JavaScript value to the console.
 @param value Value to log out in the console.
 */
- (void)logValue:(JSValue *)value;

@end
