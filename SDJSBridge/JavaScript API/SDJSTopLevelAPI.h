//
//  SDJSTopLevelAPI.h
//  SDJSBridge
//
//  Created by Brandon Sneed on 9/22/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@class SDJSPlatformAPI;
@class SDWebViewController;

extern NSString * const SDJSTopLevelAPIScriptName;

@protocol SDJSTopLevelAPIExports <JSExport>
@property (nonatomic, strong) SDJSPlatformAPI *platform;
@end

@interface SDJSTopLevelAPI : SDJSBridgeScript<SDJSTopLevelAPIExports>

@property (nonatomic, strong) SDJSPlatformAPI *platform;

@end
