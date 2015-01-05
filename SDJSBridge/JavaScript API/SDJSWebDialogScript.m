//
//  SDJSWebDialogScript.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/5/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import "SDJSWebDialogScript.h"
#import "SDWebViewController.h"
#import "SDJSHandlerScript.h"
#import "SDMacros.h"

NSString * const SDJSWebDialogScriptTitleKey = @"title";
NSString * const SDJSWebDialogScriptBodyKey = @"body";
NSString * const SDJSWebDialogScriptOkButtonKey = @"okButton";
NSString * const SDJSWebDialogScriptCancelButtonKey = @"cancelButton";
NSString * const SDJSWebDialogScriptNeutralButtonKey = @"neutralButton";
NSString * const SDJSWebDialogScriptHandleAcceptKey = @"handleAccept";

@implementation SDJSWebDialogScript

- (void)showWebDialogWithOptions:(NSDictionary *)options callback:(SDBridgeHandlerCallbackBlock)callback {
    
}

@end
