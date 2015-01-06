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
NSString * const SDJSWebDialogActionTypeOk = @"ok";
NSString * const SDJSWebDialogActionTypeNeutral = @"neutral";
NSString * const SDJSWebDialogActionTypeCancel = @"cancel";

@interface SDJSWebDialogScript ()

@property (nonatomic, copy) SDBridgeHandlerCallbackBlock callback;

@end

@implementation SDJSWebDialogScript

#pragma mark - Tap Events

- (void)cancelButtonTapped:(id)sender {
    [self triggerAction:SDJSWebDialogActionTypeCancel];

}

- (void)okayButtonTapped:(id)sender {
    [self triggerAction:SDJSWebDialogActionTypeOk];
}

#pragma mark -

- (void)triggerAction:(NSString *)action {
    [self.webViewController dismissViewControllerAnimated:YES completion:nil];
    
    if (self.callback) {
        self.callback(@{@"action" : action});
    }
}

#pragma mark - External API

- (void)showWebDialogWithOptions:(NSDictionary *)options callback:(SDBridgeHandlerCallbackBlock)callback {
    self.callback = [callback copy];
    
    NSString *title = options[SDJSWebDialogScriptTitleKey];
    NSString *body = options[SDJSWebDialogScriptBodyKey];
    NSString *cancelTitle = options[SDJSWebDialogScriptCancelButtonKey];
    NSString *okTitle = options[SDJSWebDialogScriptOkButtonKey];
    
    @strongify(self.webViewController, strongWebViewController);
  
    SDWebViewController *modalWebViewController = [strongWebViewController presentModalHTML:body title:title];
    
    if (cancelTitle) {
        modalWebViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:cancelTitle
                                                                                                   style:UIBarButtonItemStylePlain
                                                                                                  target:self
                                                                                                  action:@selector(cancelButtonTapped:)];
    }
    
    if (okTitle) {
        modalWebViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:okTitle
                                                                                                    style:UIBarButtonItemStylePlain
                                                                                                   target:self
                                                                                                   action:@selector(okayButtonTapped:)];
    }
}

@end
