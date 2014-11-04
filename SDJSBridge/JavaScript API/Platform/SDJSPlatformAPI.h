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

@protocol SDJSPlatformAPIExports <JSExport>

@property (nonatomic, strong) SDJSNavigationAPI *navigation;

JSExportAs(AlertAction, - (SDJSAlertAction *)alertActionWithTitle:(NSString *)title callback:(JSValue *)callback);

@end

@interface SDJSPlatformAPI : SDJSBridgeScript <SDJSPlatformAPIExports>

@property (nonatomic, strong) SDJSNavigationAPI *navigation;

- (SDJSAlertAction *)alertActionWithTitle:(NSString *)title callback:(JSValue *)callback;

@end
