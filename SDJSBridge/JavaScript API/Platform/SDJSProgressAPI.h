//
//  SDJSProgressAPI.h
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
@protocol SDJSProgressAPIDelegate <NSObject>

/**
 Show the progress HUD
 @param message Message text to display in the progerss HUD.
 */
- (void)showProgressHUDWithMessage:(NSString *)message;

/**
 Hide the progress HUD
 */
- (void)hideProgressHUD;

@end

@protocol SDJSProgressAPIExports <JSExport>

@property (nonatomic, copy) NSString *message;

JSExportAs(show, - (void)showWithMessage:(NSString *)message);
- (void)hide;

@end

/**
 A JavaScript bridge script for interacting with a progress HUD object. The 
 object requires a delegate to handle hiding and showing of the progress HUD.
 
 ## JavaScript Usage
 
 Showing a progress HUD with message text.
 
     JSBridgeAPI.platform().progress().show("One moment please...");
 
 Hiding a progress HUD.

     JSBridgeAPI.platform().progress().hide();

 */
@interface SDJSProgressAPI : SDJSBridgeScript <SDJSProgressAPIExports>

/**
 Message text to display.
 */
@property (nonatomic, copy) NSString *message;

/**
 Progress API delegate. The delgate handles showing/hiding the progress HUD.
 */
@property (nonatomic, weak) id<SDJSProgressAPIDelegate> delegate;

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

@end
