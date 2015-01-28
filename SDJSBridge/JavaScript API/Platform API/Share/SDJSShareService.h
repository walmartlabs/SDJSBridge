//
//  SDJSShareService.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/13/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

/**
 An object used to represent a `UIActivityType` in JavaScript. Allows
 JavaScript API users to specify activity types.
  
 ## JavaScript Usage
 
 Showing a share sheet that excludes the Facebook and Mail options.
 
     var ShareService = JSBridgeAPI.platform().ShareService();
     var excludedServices = [ShareService.Facebook, ShareService.Mail];
     
     JSBridgeAPI.platform().share(url, message, excludedServices, function () {
       // share complete
     });
 
 */
@interface SDJSShareService : NSObject

/**
 Activity type constant.
 */
@property (nonatomic, copy, readonly) NSString *activityType;

+ (NSDictionary *)allServices;

/// @name Creating Share Services

/**
 Creates a share service for the facebook activity type.
 */
+ (SDJSShareService *)facebook;

/**
 Creates a share service for the mail activity type.
 */
+ (SDJSShareService *)mail;

/**
 Creates a share service for the message activity type.
 */
+ (SDJSShareService *)message;

/**
 Creates a share service for the twitter activity type.
 */
+ (SDJSShareService *)twitter;

/**
 Creates a share service for the flickr activity type.
 */
+ (SDJSShareService *)flickr;

/**
 Creates a share service for the vimeo activity type.
 */
+ (SDJSShareService *)vimeo;

/// @name Converting to Activity Types

/**
 Returns an array of `UIActivityType` constants from an array of 
 SDJSShareService objects.
 */
+ (NSArray *)activityTypesFromShareServices:(NSArray *)shareServices;

@end
