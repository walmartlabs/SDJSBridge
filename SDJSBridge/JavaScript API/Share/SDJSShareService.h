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
 An object used to represent a UIActivityType in JavaScript. Allows
 JavaScript API users to specify activity types.
 
 ## Usage
 
 ### JavaScript
 
 Showing a share sheet that excludes the Facebook and Mail options.
 
     var ShareService = JSBridgeAPI.platform().ShareService();
     var excludedServices = [ShareService.Facebook, ShareService.Mail];
     
     JSBridgeAPI.platform().share(url, message, excludedServices, function () {
       // share complete
     });
 
 */
@interface SDJSShareService : NSObject

@property (nonatomic, copy, readonly) NSString *activityType;

+ (NSDictionary *)allServices;
+ (SDJSShareService *)facebook;
+ (SDJSShareService *)mail;
+ (SDJSShareService *)message;
+ (SDJSShareService *)twitter;
+ (SDJSShareService *)flickr;
+ (SDJSShareService *)vimeo;
+ (NSArray *)activityTypesFromShareServices:(NSArray *)shareServices;

@end
