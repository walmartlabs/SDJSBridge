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

/**
 A protocol that describes how the navigation API is exported to JavaScript.
 */
@protocol SDJSNavigationAPIExports <JSExport>

/// @name JavaScript API

/**
 Push a URL on to the navigation stack with a URL string and title text.
 @param urlString URL string of URL to push.
 @param title Title text to use for the view controller title.
 */
JSExportAs(pushUrl,- (void)pushUrl:(NSString *)urlString title:(NSString *)title);
- (void)popUrl;

/**
 Present a modal web view with a URL string and title text.
 @param urlString URL string of URL to push.
 @param title Title text to use for the view controller title.
 */
JSExportAs(presentModalUrl, - (void)presentModalUrl:(NSString *)urlString title:(NSString *)title);

/**
 Dismiss current modal web view.
 */
- (void)dismissModalUrl;

/**
 API for interacting with the navigation bar.
 */
- (SDJSNavigationBarAPI *)navigationBar;

/**
 Create a navigation item with a title, image name and callback.
 @param title Title text to use for the navigation item button.
 @param imageName Name of image to load from the bundle to use for the navigation item button background.
 @param callback JS function to call when navigation item button is tapped.
 @return A new navigation item object.
 */
JSExportAs(NavigationItem, - (SDJSNavigationItem *)navigationItemWithTitle:(NSString *)title imageName:(NSString *)imageName callback:(JSValue *)callback);

@end

/**
 A JavaScript bridge script for interacting with the navigation controller of a 
 SDWebViewController instance.

 ## JavaScript Usage

 Pushing a web view on to the navigation stack.

     var navigation = JSBridgeAPI.platform().navigation();
     navigation..pushUrl("http://www.google.com/", "Google");

 Popping a web view off of the navigation stack

     var navigation = JSBridgeAPI.platform().navigation();
     navigation.popUrl();

 Presenting a modal web view.

     var navigation = JSBridgeAPI.platform().navigation();
     navigation.presentModalUrl("http://www.google.com/", "Google");

 Dismissing a modal web view.

     var navigation = JSBridgeAPI.platform().navigation();
     navigation.dismissModalUrl();

 */
@interface SDJSNavigationAPI : SDJSBridgeScript <SDJSNavigationAPIExports>

/**
 Bridge script that provides the navigation bar API bridge.
 */
@property (nonatomic, strong) SDJSNavigationBarAPI *navigationBarScript;

/// @name Navigating View Controllers

/**
 Push a web view controller on to the navigation stack with a URL string and title text.
 @param urlString URL string of URL to push.
 @param title Title text to use for the view controller title.
 */
- (void)pushUrl:(NSString *)urlString title:(NSString *)title;

/**
 Pop a web view controller off of the navigation stack.
 */
- (void)popUrl;

/**
 Present a modal web view controller with a URL string and title text.
 @param urlString URL string of URL to push.
 @param title Title text to use for the view controller title.
 */
- (void)presentModalUrl:(NSString *)urlString title:(NSString *)title;

/**
 Dismiss a modal web view controller.
 */
- (void)dismissModalUrl;

/// @name Creating Navigation Items

/**
 Create a navigation item with a title, image name and callback.
 @param title Title text to use for the navigation item button.
 @param imageName Name of image to load from the bundle to use for the navigation item button background.
 @param callback JS function to call when navigation item button is tapped.
 @return A new navigation item object.
 */
- (SDJSNavigationItem *)navigationItemWithTitle:(NSString *)title imageName:(NSString *)imageName callback:(JSValue *)callback;

@end
