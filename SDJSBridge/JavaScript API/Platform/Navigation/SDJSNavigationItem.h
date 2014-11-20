//
//  SDJSNavigationItem.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/3/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeResponder.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

/**
 A protocol that describes how a SDJSNavigationItem object is exported
 to JavaScript.
 */
@protocol SDJSNavigationItemExports <JSExport>

/// @name JavaScript API

/**
 Title text to use for button label text.
 */
@property (nonatomic, copy) NSString *title;

/**
 Image name to load from bundle and use as button background.
 */
@property (nonatomic, copy) NSString *imageName;

@end

/**
 A JavaScript bridge script for creating UIBarButtonItem objects from JavaScript.

 ## JavaScript Usage

 Creating a navigation item button with a title.

     var navigation = JSBridgeAPI.platform().navigation();

     var cancelButton = navigation().NavigationItem("Cancel", null, function () {
       navigation.dismissModalUrl();
     });


 Creating a navigation item button with an image.

     var navigation = JSBridgeAPI.platform().navigation();

     var infoButton = navigation().NavigationItem(null, "info-icon", function () {
       navigation.presentModalUrl("/info", "Info");
     });

 */
@interface SDJSNavigationItem : SDJSBridgeResponder <SDJSNavigationItemExports>

/**
 Title text for button label.
 */
@property (nonatomic, copy) NSString *title;

/**
 Image name to load from bundle and use as button background.
 */
@property (nonatomic, copy) NSString *imageName;

/// @name Creating a Navigation Item

/**
 Creates a navigation item object.
 @param title Title text for button label.
 @param imageName Optional image name to load from bundle and use as button background.
 @param callback JS function to callback when the button is tapped.
 */
+ (instancetype)navigationItemWithTitle:(NSString *)title imageName:(NSString *)imageName callback:(JSValue *)callback;

/// @name Creating a Bar Button Items

/**
 Create a UIBarButton instance based on the navigation item.
 */
- (UIBarButtonItem *)barButtonItem;

@end
