//
//  SDJSPlatformScript.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/5/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import "SDJSHandlerScript.h"
#import "SDJSAlertScript.h"
#import "SDJSNavigationScript.h"
#import "SDJSProgressHUDScript.h"
#import "SDJSShareScript.h"
#import "SDJSWebDialogScript.h"
#import "SDJSRadioDialogScript.h"

extern NSString * const SDJSPlatformScriptName;

/**
 A protocol that describes how the top level API is exported to JavaScript.
 */
@protocol SDJSPlatformScriptExports <JSExport>

/// @name JavaScript API

/**
 Log JavaScript values in Objective-C.
 */
JSExportAs(log, - (void)logValue:(JSValue *)value);

@end


@interface SDJSPlatformScript : SDJSHandlerScript <SDJSPlatformScriptExports,
                                                   SDJSAlertScriptExports,
                                                   SDJSNavigationScriptExports,
                                                   SDJSProgressHUDScriptExports,
                                                   SDJSShareScriptExports,
                                                   SDJSWebDialogScriptExports,
                                                   SDJSRadioDialogScriptExports>

/**
 Progress HUD API script.
 */
@property (nonatomic, strong) SDJSProgressHUDScript *progressScript;

/**
 Share API script.
 */
@property (nonatomic, strong) SDJSShareScript *shareScript;

@property (nonatomic, strong) SDJSRadioDialogScript *radioDialogScript;

/// @name Logging JavaScript Values

/**
 Log a JavaScript value to the console.
 @param value Value to log out in the console.
 */
- (void)logValue:(JSValue *)value;


@end
