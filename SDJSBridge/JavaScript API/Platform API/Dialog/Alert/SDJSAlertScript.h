//
//  SDJSAlertScript.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/19/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"
#import "SDJSHandlerScript.h"

#import <JavaScriptCore/JavaScriptCore.h>

@protocol SDJSAlertScriptExports <JSExport>

JSExportAs(alert, - (void)showAlertWithOptions:(NSDictionary *)options callback:(JSValue *)callback);

@end

@interface SDJSAlertScript : SDJSBridgeScript

- (void)showAlertWithOptions:(NSDictionary *)options callback:(JSValue *)callback;

@end
