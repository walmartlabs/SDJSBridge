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
@class SDJSProgressAPI;
@class SDJSShareAPI;
@class SDJSShareService;

/**
 A protocol that describes how the platform API is exported to JavaScript.
 */
@protocol SDJSPlatformAPIExports <JSExport>

/// @name JavaScript API

/**
 Returns the navigation API script.
 */
- (SDJSNavigationAPI *)navigation;

/**
 Returns the progress API script.
 */
- (SDJSProgressAPI *)progress;

/**
 Returns the share service constants. (Ex: ShareService.Facebook, ShareService.Mail)
 */
- (NSDictionary *)ShareService;

/**
 Share a URL with message text.
 */
JSExportAs(share, - (UIActivityViewController *)shareURL:(NSString *)urlString message:(NSString *)message callback:(JSValue *)callback);

/**
 Share a URL with message text and exclude some share services.
 */
JSExportAs(share, - (UIActivityViewController *)shareURL:(NSString *)urlString message:(NSString *)message excludedServices:(NSArray *)excludedServices callback:(JSValue *)callback);

@end

/**
 A JavaScript bridge script for interacting with the platform API.
  
 ## JavaScript Usage
 
 ### Sharing
 
 Sharing a URL with message text. 

     var url = "http://www.walmart.com/";
     var message = "Check out this great deal!"
     JSBridgeAPI.platform().share(url, message, function () {
         // share complete
     });
 
 */
@interface SDJSPlatformAPI : SDJSBridgeScript <SDJSPlatformAPIExports>

/**
 Navigation API script that provides the navigation API bridge.
 */
@property (nonatomic, strong) SDJSNavigationAPI *navigationScript;

/**
 Progress API script that provides the progress API bridge.
 */
@property (nonatomic, strong) SDJSProgressAPI *progressScript;

/**
 Share API script that provides the share API bridge.
 */
@property (nonatomic, strong) SDJSShareAPI *shareScript;

/// @name Sharing

/**
 Share an item with a URL and message.
 @param url URL of the item being shared.
 @param message Message text of the item being shared.
 @param url URL of the item being shared.
 @param excludedServices Array of share services (SDJSShareService instances) to
 exclude.
 */
- (UIActivityViewController *)shareURL:(NSString *)urlString message:(NSString *)message callback:(JSValue *)callback;

/**
 Share an item with a URL and message.
 @param url URL of the item being shared.
 @param message Message text of the item being shared.
 @param url URL of the item being shared.
 @param excludedServices Array of share services (SDJSShareService instances) to
 exclude.
 @param callback JS function to callback when user has completed sharing.
 */
- (UIActivityViewController *)shareURL:(NSString *)urlString message:(NSString *)message excludedServices:(NSArray *)excludedServices callback:(JSValue *)callback;

@end
