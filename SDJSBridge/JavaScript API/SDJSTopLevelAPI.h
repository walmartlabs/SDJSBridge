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

@protocol SDJSTopLevelAPIExports <JSExport>

- (SDJSPlatformAPI *)platform;
JSExportAs(log, - (void)logValue:(JSValue *)value);

@end

/**
 A JavaScript bridge for interacting with the top level of the SDJSBridgeAPI.
 */
@interface SDJSTopLevelAPI : SDJSBridgeScript<SDJSTopLevelAPIExports>

@property (nonatomic, strong) SDJSPlatformAPI *platformScript;

- (void)logValue:(JSValue *)value;

@end
