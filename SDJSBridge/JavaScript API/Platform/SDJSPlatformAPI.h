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

- (SDJSNavigationAPI *)navigation;
- (SDJSProgressAPI *)progress;
- (NSDictionary *)ShareService;
JSExportAs(AlertAction, - (SDJSAlertAction *)alertActionWithTitle:(NSString *)title callback:(JSValue *)callback);
JSExportAs(alert, - (void)showAlert:(NSString *)title message:(NSString *)message actions:(NSArray *)actions);
JSExportAs(share, - (void)shareURL:(NSString *)urlString message:(NSString *)message callback:(JSValue *)callback);
JSExportAs(share, - (void)shareURL:(NSString *)urlString message:(NSString *)message excludedServices:(NSArray *)excludedServices callback:(JSValue *)callback);

@end

/**
 A JavaScript bridge script for interacting with the platform API.
  
 ### JavaScript Usage
 
 Displaying an alert.
 
     var platform = JSBridgeAPI.platform();
     
     // null actions default to OK action
     platform.alert("Error", "An error occured while logging in", null);
 
 
 Sharing a URL with message text. 

     var url = "http://www.walmart.com/";
     var message = "Check out this great deal!"
     JSBridgeAPI.platform().share(url, message, function () {
         // share complete
     });
 
 */
@interface SDJSPlatformAPI : SDJSBridgeScript <SDJSPlatformAPIExports, UIAlertViewDelegate>

@property (nonatomic, strong) SDJSNavigationAPI *navigationScript;
@property (nonatomic, strong) SDJSProgressAPI *progressScript;
@property (nonatomic, strong) SDJSShareAPI *shareScript;

/// @name Creating Alert Actions

- (SDJSAlertAction *)alertActionWithTitle:(NSString *)title callback:(JSValue *)callback;

/// @name Displaying Alert

/**
 Display a UIAlertView.
 @param Title text for alert.
 @param Message text for alert.
 @param Array of SDJSAlertAction objects.
 */
- (void)showAlert:(NSString *)title message:(NSString *)message actions:(NSArray *)actions;

/// @name Sharing

/**
 Share an item with a URL and message.
 @param url URL of the item being shared.
 @param message Message text of the item being shared.
 @param url URL of the item being shared.
 @param excludedServices Array of share services (SDJSShareService instances) to
 exclude.
 */
- (void)shareURL:(NSString *)urlString message:(NSString *)message callback:(JSValue *)callback;

/**
 Share an item with a URL and message.
 @param url URL of the item being shared.
 @param message Message text of the item being shared.
 @param url URL of the item being shared.
 @param excludedServices Array of share services (SDJSShareService instances) to
 exclude.
 @param callback JS function to callback when user has completed sharing.
 */
- (void)shareURL:(NSString *)urlString message:(NSString *)message excludedServices:(NSArray *)excludedServices callback:(JSValue *)callback;

@end
