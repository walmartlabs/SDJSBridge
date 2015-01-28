//
//  SDJSWebDialogScript.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/5/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"
#import "SDJSHandlerScript.h"

@protocol SDJSWebDialogScriptExports <JSExport>

JSExportAs(webDialog, - (void)showWebDialogWithOptions:(NSDictionary *)options callback:(JSValue *)callback);

@end

@interface SDJSWebDialogScript : SDJSBridgeScript

- (void)showWebDialogWithOptions:(NSDictionary *)options callback:(SDBridgeHandlerOutputBlock)callback;

@end
