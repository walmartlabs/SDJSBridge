//
//  SDJSBridgeScript.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/3/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SDWebViewController;

/**
 An abstract class for creating a JavaScript bridge script that interacts with
 a SDWebViewController instance. Subclass to create custom bridge scripts.
 */
@interface SDJSBridgeScript : NSObject

/**
 Parent web view controller if the script.
 */
@property (nonatomic, weak, readonly) SDWebViewController *webViewController;

/// @name Initializaing a Bridge Script

/**
 Create a new bridge script with weak reference to a parent web view controller.
 */
- (instancetype)initWithWebViewController:(SDWebViewController *)webViewController;

@end
