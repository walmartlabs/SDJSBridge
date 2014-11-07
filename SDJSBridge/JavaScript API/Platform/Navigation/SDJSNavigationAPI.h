//
//  SDJSNavigationAPI.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 10/30/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@class SDJSNavigationBarAPI;
@class SDJSNavigationItem;

@protocol SDJSNavigationAPIExports <JSExport>

@property (nonatomic, strong) SDJSNavigationBarAPI *navigationBar;

JSExportAs(pushUrl,- (void)pushUrl:(NSString *)urlString title:(NSString *)title);
- (void)popUrl;
JSExportAs(presentModalUrl, - (void)presentModalUrl:(NSString *)urlString title:(NSString *)title);
- (void)dismissModalUrl;
JSExportAs(NavigationItem, - (SDJSNavigationItem *)navigationItemWithTitle:(NSString *)title imageName:(NSString *)imageName callback:(JSValue *)callback);

@end

/**
 A JavaScript bridge script for interacting with the navigation controller of a 
 SDWebViewController instance.
 */
@interface SDJSNavigationAPI : SDJSBridgeScript <SDJSNavigationAPIExports>

@property (nonatomic, strong) SDJSNavigationBarAPI *navigationBar;

/// @name Navigating View Controllers

- (void)pushUrl:(NSString *)urlString title:(NSString *)title;
- (void)popUrl;
- (void)presentModalUrl:(NSString *)urlString title:(NSString *)title;
- (void)dismissModalUrl;

/// @name Creating Navigation Items

- (SDJSNavigationItem *)navigationItemWithTitle:(NSString *)title imageName:(NSString *)imageName callback:(JSValue *)callback;

@end
