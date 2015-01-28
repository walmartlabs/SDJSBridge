//
//  SDJSNavigationScript.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/22/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"

#import <JavaScriptCore/JavaScriptCore.h>

@protocol SDJSNavigationScriptExports <JSExport>

JSExportAs(pushState, - (void)pushStateWithOptions:(NSDictionary *)options);
JSExportAs(replaceState, - (void)replaceStateWithOptions:(NSDictionary *)options);
- (void)back;

@end

@interface SDJSNavigationScript : SDJSBridgeScript

- (void)pushStateWithOptions:(NSDictionary *)options;
- (void)replaceStateWithOptions:(NSDictionary *)options;
- (void)back;

@end
