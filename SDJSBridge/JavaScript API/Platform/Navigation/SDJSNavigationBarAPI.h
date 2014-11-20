//
//  SDJSNavigationBarAPI.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/3/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

/**
 A protocol that describes how the navigation bar API is exported to JavaScript.
 */
@protocol SDJSNavigationBarAPIExports <JSExport>

/**
 Retreive the bar's left navigation items.
 @return An array of SDJSNavigationItem objects.
 */
- (NSArray *)leftItems;

/**
 Retreive the bar's right navigation items.
 @return An array of SDJSNavigationItem objects.
 */
- (NSArray *)rightItems;

/**
 Set the bar's left navigation items.
 @param leftItems An array of SDJSNavigationItem objects.
 */
- (void)setLeftItems:(NSArray *)leftItems;

/**
 Set the bar's right navigation items.
 @param rightItems An array of SDJSNavigationItem objects.
 */
- (void)setRightItems:(NSArray *)rightItems;

@end

/**
 A JavaScript bridge script for interacting with the navigation items of a 
 SDWebViewController instance.

 ## JavaScript Usage

     Adding navigation items to the navigation bar.

     var navigation = JSBridgeAPI.platform().navigation();

     var cancelButton = navigation.NavigationItem("Cancel", null, function () {
       navigation.dismissModalUrl();
     });

     navigation.navigationBar.setLeftItems([cancelButton]);

 Removing items from the navigation bar.

     var navigation = JSBridgeAPI.platform().navigation();

     var leftItems = navigation.navigationBar().leftItems().splice(0, 1);
     navigation.navigationBar().setLeftItems(leftItems);

 */
@interface SDJSNavigationBarAPI : SDJSBridgeScript <SDJSNavigationBarAPIExports>

@end
