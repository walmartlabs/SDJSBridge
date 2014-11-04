//
//  SDJSPlatformAPI.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 10/30/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>
#import "SDJSBridgeScript.h"
#import "SDJSNavigationItem.h"

@class SDJSNavigationAPI;

@protocol SDJSPlatformAPIExports <JSExport>

@property (nonatomic, strong) SDJSNavigationAPI *navigation;

JSExportAs(NavigationItem,
- (SDJSNavigationItem *)navigationItemWithTitle:(NSString *)title imageName:(NSString *)imageName callback:(JSValue *)callback
);


@end

@interface SDJSPlatformAPI : SDJSBridgeScript <SDJSPlatformAPIExports>

@property (nonatomic, strong) SDJSNavigationAPI *navigation;

- (SDJSNavigationItem *)navigationItemWithTitle:(NSString *)title imageName:(NSString *)imageName callback:(JSValue *)callback;

@end
