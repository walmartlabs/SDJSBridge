//
//  SDJSProgressHUDScript.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/6/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"

#import <JavaScriptCore/JavaScriptCore.h>

/**
 A delegate protocol for handling the showing and hiding of a progress HUD.
 Implement to control how the progress HUD is shown and hidden.
 */
@protocol SDJSProgressHUDScriptDelegate <NSObject>

/**
 Show the progress HUD
 @param message Message text to display in the progerss HUD.
 */
- (void)progressScriptShowProgressHUDWithMessage:(NSString *)message;

/**
 Hide the progress HUD
 */
- (void)progressScriptHideProgressHUD;

@end

/**
 A protocol that describes how the progress HUD API is exported to JavaScript.
 */
@protocol SDJSProgressHUDScriptExports <JSExport>

/// @name JavaScript API

/**
 Show the progress HUD and display the provided message text.
 */
JSExportAs(showLoadingIndicator, - (void)showLoadingIndicatorWithOptions:(NSDictionary *)options);

/**
 Hide progress HUD.
 */
- (void)hideLoadingIndicator;

@end

/**
 A JavaScript bridge script for interacting with a loading progress HUD object. The
 object requires a delegate to handle hiding and showing of the progress HUD.

 ## JavaScript Usage

 Showing a progress HUD with message text.

     var options = {
       message: 'Loading...'
     };

     JSBridgeAPI.showLoadingIndicator(options);

 Hiding a progress HUD.

     JSBridgeAPI.hideLoadingIndicator();

 */
@interface SDJSProgressHUDScript : SDJSBridgeScript

/**
 Progress API delegate. The delgate handles showing/hiding the progress HUD.
 */
@property (nonatomic, weak) id<SDJSProgressHUDScriptDelegate> delegate;

/// @name Showing and Hiding the Progress HUD

/**
 Show the progress HUD.
 @param message Message text to display in the progerss HUD.
 */
- (void)showWithMessage:(NSString *)message;

/**
 Hide the progress HUD.
 */
- (void)hide;

- (void)showLoadingIndicatorWithOptions:(NSDictionary *)options;

@end
