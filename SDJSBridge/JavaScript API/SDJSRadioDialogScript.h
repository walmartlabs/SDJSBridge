//
//  SDJSRadioDialogScript.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/7/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"
#import "SDJSHandlerScript.h"

#import <JavaScriptCore/JavaScriptCore.h>

@protocol SDJSRadioDialogScriptExports <JSExport>

JSExportAs(radioDialog, - (void)showRadioDialogWithOptions:(NSDictionary *)options callback:(JSValue *)callback);

@end

@interface SDJSRadioDialogScript : SDJSBridgeScript

- (void)showRadioDialogWithOptions:(NSDictionary *)options callback:(SDBridgeHandlerCallbackBlock)callback;

@end
