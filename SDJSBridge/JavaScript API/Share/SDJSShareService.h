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

@interface SDJSShareService : NSObject

@property (nonatomic, copy, readonly) NSString *activityType;

+ (SDJSShareService *)facebook;
+ (SDJSShareService *)mail;
+ (SDJSShareService *)message;
+ (SDJSShareService *)twitter;
+ (SDJSShareService *)flickr;
+ (SDJSShareService *)vimeo;

@end
