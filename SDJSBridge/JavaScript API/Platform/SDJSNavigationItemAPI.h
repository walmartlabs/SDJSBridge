//
//  SDJSNavigationItemAPI.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/3/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

#import "SDJSNavigationItem.h"

@protocol SDJSNavigationItemAPIExports <JSExport>

- (SDJSNavigationItem *)navigationItemWithTitle:(NSString *)title
                                      imageName:(NSString *)imageName
                                       callback:(SDJSNavigationItemCallback)callback;

@end

@interface SDJSNavigationItemAPI : SDJSBridgeScript

- (SDJSNavigationItem *)navigationItemWithTitle:(NSString *)title
                                      imageName:(NSString *)imageName
                                       callback:(SDJSNavigationItemCallback)callback;

@end
