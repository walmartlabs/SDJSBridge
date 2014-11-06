//
//  SDJSProgressAPI.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/6/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"

#import <JavaScriptCore/JavaScriptCore.h>

@protocol SDJSProgressAPIExports <JSExport>

@property (nonatomic, copy) NSString *message;

JSExportAs(show, - (void)showWithMessage:(NSString *)message);
- (void)hide;

@end

@interface SDJSProgressAPI : SDJSBridgeScript

@property (nonatomic, copy) NSString *message;

- (void)showWithMessage:(NSString *)message;
- (void)hide;

@end
