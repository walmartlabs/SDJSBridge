//
//  SDJSAlertAction.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/4/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeResponder.h"

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

/**
 A protocol that describes how a SDJSAlertAction object is exported 
 to JavaScript.
 */
@protocol SDJSAlertActionExports <JSExport>

/// @name JavaScript API

/**
 Title of the alert action. Used as the button label text.
 */
@property (nonatomic, copy) NSString *title;

@end

/**
 A JavaScript bridge to represent an alert action object. Alert actions are
 used to add button to a UIAlertView.
 
 ## JavaScript Usage
 
 Adding buttons with actions to alerts.

     var platform = JSBridgeAPI.platform;

     var okAction = platform.AlertAction("OK", function () {
       // ok button was tapped
     });

     var cancelAction = platform.AlertAction("Cancel", function () {
       // cancel button was tapped
     });

     var alertActions = [okAction, cancelAction];

     platform.alert("Receipt Not Found", "Are you sure you want to proceed?", alertActions);
     
 */
@interface SDJSAlertAction : SDJSBridgeResponder <SDJSAlertActionExports>

/**
 Title text used for button label.
 */
@property (nonatomic, copy) NSString *title;

/// @name Creating Alert Actions

/**
 Creates an alert action
 @param title Title text used for button label.
 @param callback JS function to callback when action is triggered.
 @return A new alert action object.
 */
+ (instancetype)alertActionWithTitle:(NSString *)title callback:(JSValue *)callback;

@end
