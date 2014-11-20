//
//  SDJSBridgeResponder.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/4/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol SDJSBridgeResponderExports <JSExport>

@property (nonatomic, strong) JSValue *callback;

@end

/**
 An abstract class for representing a JavaScript bridge script that invokes a
 callback when performing an action. A responder is initialized with a JavaScript
 function to call when the responder's action is triggered. 
 
 ## Usage
 
 Subclass to implement a target/action callback pattern that can be exposed to 
 JavaScript.

     @interface MyButtonActionScript : SDJSBridgeResponder
     @end

 Call the `performActionWithSender:` method to invoke the JavaScript callback.

     - (IBAction)buttonTapped:(id)sender {
         MyButtonActionScript *buttonScript;
         [buttonScript performActionWithSender:sender];
     }
 

 SDJSAlertAction *alertAction = [[SDJSAlertAction alloc] initWithCallback:callback];
 */
@interface SDJSBridgeResponder : SDJSBridgeScript <SDJSBridgeResponderExports>

/**
 JavaScript function to call as the callback.
 */
@property (nonatomic, strong) JSValue *callback;

/// @name Initializing a Bridge Responder Script Object

/**
 Create a new bridge responder script.
 @param webViewController Parent web view controller of the script.
 @param callback JavaScript function to call as the callback.
 @return A new bridge responder script.
 */
- (instancetype)initWithWebViewController:(SDWebViewController *)webViewController callback:(JSValue *)callback;

/**
 Create a new bridge responder script.
 @param callback JavaScript function to call as the callback.
 @return A new bridge responder script.
 */
- (instancetype)initWithCallback:(JSValue *)callback;

/**
 Invoke the JavaScript callback.
 */
- (void)performActionWithSender:(id)sender;

@end
