//
//  SDJSPlatformAPI.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 10/30/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"

#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>

@class SDJSNavigationAPI;
@class SDJSAlertAction;
@class SDJSProgressAPI;

@protocol SDJSPlatformAPIExports <JSExport>

@property (nonatomic, strong) SDJSNavigationAPI *navigation;
@property (nonatomic, strong) SDJSProgressAPI *progress;

JSExportAs(AlertAction, - (SDJSAlertAction *)alertActionWithTitle:(NSString *)title callback:(JSValue *)callback);
JSExportAs(alert, - (void)showAlert:(NSString *)title message:(NSString *)message actions:(NSArray *)actions);

@end

/**
 A JavaScript bridge script for interacting with the platform API.
 */
@interface SDJSPlatformAPI : SDJSBridgeScript <SDJSPlatformAPIExports, UIAlertViewDelegate>

@property (nonatomic, strong) SDJSNavigationAPI *navigation;
@property (nonatomic, strong) SDJSProgressAPI *progress;

- (SDJSAlertAction *)alertActionWithTitle:(NSString *)title callback:(JSValue *)callback;
- (void)showAlert:(NSString *)title message:(NSString *)message actions:(NSArray *)actions;

@end
