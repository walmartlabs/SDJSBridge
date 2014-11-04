//
//  SDJSNavigationAPI.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 10/30/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@class SDWebViewController;
@class SDJSNavigationBarAPI;
@class SDJSNavigationItem;

@protocol SDJSNavigationAPIExports <JSExport>

@property (nonatomic, strong) SDJSNavigationBarAPI *navigationBar;

JSExportAs(pushURL,
- (void)pushURL:(NSString *)urlString title:(NSString *)title
);

- (void)popURL;

JSExportAs(presentModalURL,
- (void)presentModalURL:(NSString *)urlString title:(NSString *)title
);

- (void)dismissModalURL;

JSExportAs(NavigationItem,
- (SDJSNavigationItem *)navigationItemWithTitle:(NSString *)title imageName:(NSString *)imageName callback:(JSValue *)callback
);

@end

@interface SDJSNavigationAPI : SDJSBridgeScript <SDJSNavigationAPIExports>

@property (nonatomic, strong) SDJSNavigationBarAPI *navigationBar;

/// @name Navigating View Controllers

- (void)pushURL:(NSString *)urlString title:(NSString *)title;
- (void)popURL;
- (void)presentModalURL:(NSString *)urlString title:(NSString *)title;
- (void)dismissModalURL;

/// @name Creating Navigation Items

- (SDJSNavigationItem *)navigationItemWithTitle:(NSString *)title imageName:(NSString *)imageName callback:(JSValue *)callback;

@end
