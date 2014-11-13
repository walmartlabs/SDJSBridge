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
@class SDJSShareAPI;
@class SDJSShareService;

@protocol SDJSPlatformAPIExports <JSExport>

@property (nonatomic, strong) SDJSNavigationAPI *navigation;
@property (nonatomic, strong) SDJSProgressAPI *progress;
@property (nonatomic, readonly) NSDictionary *ShareService;

/// @name Alerts

JSExportAs(AlertAction, - (SDJSAlertAction *)alertActionWithTitle:(NSString *)title callback:(JSValue *)callback);
JSExportAs(alert, - (void)showAlert:(NSString *)title message:(NSString *)message actions:(NSArray *)actions);

/// @name Sharing

JSExportAs(share, - (void)shareURL:(NSString *)urlString message:(NSString *)message callback:(JSValue *)callback);
JSExportAs(share, - (void)shareURL:(NSString *)urlString message:(NSString *)message excludedServices:(NSArray *)excludedServices callback:(JSValue *)callback);

@end

/**
 A JavaScript bridge script for interacting with the platform API.
 */
@interface SDJSPlatformAPI : SDJSBridgeScript <SDJSPlatformAPIExports, UIAlertViewDelegate>

@property (nonatomic, strong) SDJSNavigationAPI *navigation;
@property (nonatomic, strong) SDJSProgressAPI *progress;
@property (nonatomic, strong) SDJSShareAPI *shareScript;
@property (nonatomic, readonly) NSDictionary *ShareService;

/// @name Alerts

- (SDJSAlertAction *)alertActionWithTitle:(NSString *)title callback:(JSValue *)callback;
- (void)showAlert:(NSString *)title message:(NSString *)message actions:(NSArray *)actions;

/// @name Sharing

- (void)shareURL:(NSString *)urlString message:(NSString *)message callback:(JSValue *)callback;
- (void)shareURL:(NSString *)urlString message:(NSString *)message excludedServices:(NSArray *)excludedServices callback:(JSValue *)callback;

@end
