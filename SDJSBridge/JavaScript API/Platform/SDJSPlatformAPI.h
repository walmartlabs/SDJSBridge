//
//  SDJSPlatformAPI.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 10/30/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>
#import "SDJSBridgeScript.h"

@class SDJSNavigationAPI;
@class SDWebViewController;

@protocol SDJSPlatformAPIExports <JSExport>

@property (nonatomic, strong) SDJSNavigationAPI *navigation;

@end

@interface SDJSPlatformAPI : SDJSBridgeScript <SDJSPlatformAPIExports>

@property (nonatomic, strong) SDJSNavigationAPI *navigation;

@end
