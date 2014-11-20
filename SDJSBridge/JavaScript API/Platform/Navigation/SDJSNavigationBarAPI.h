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

@protocol SDJSNavigationBarAPIExports <JSExport>

- (NSArray *)leftItems;
- (NSArray *)rightItems;
- (void)setLeftItems:(NSArray *)leftItems;
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
