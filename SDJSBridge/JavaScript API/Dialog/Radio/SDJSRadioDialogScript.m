//
//  SDJSRadioDialogScript.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/7/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import "SDJSRadioDialogScript.h"

static NSString * const kSDJSRadioDialogScriptTitleKey = @"title";
static NSString * const kSDJSRadioDialogScriptItemsKey = @"items";
static NSString * const kSDJSRadioDialogScriptOkButtonKey = @"okButton";
static NSString * const kSDJSRadioDialogScriptCancelButtonKey = @"cancelButton";
static NSString * const kSDJSRadioDialogScriptNeutralButtonKey = @"neutralButton";
static NSString * const kSDJSRadioDialogScriptHandleAcceptKey = @"handleAccept";
static NSString * const kSDJSRadioDialogScriptActionKey = @"action";
static NSString * const kSDJSRadioDialogScriptSelectedItemsKey = @"selectedItems";

@implementation SDJSRadioDialogScript

#pragma mark - 

#pragma mark - SDJSRadioDialogDelegate

#pragma mark - External API

- (void)showRadioDialogWithOptions:(NSDictionary *)options callback:(SDBridgeHandlerCallbackBlock)callback {
    
}

@end
