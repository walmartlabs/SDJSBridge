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

static NSString * const kSDJSWebDialogScriptTitleKey = @"title";
static NSString * const kSDJSWebDialogScriptBodyKey = @"body";
static NSString * const kSDJSWebDialogScriptOkButtonKey = @"okButton";
static NSString * const kSDJSWebDialogScriptCancelButtonKey = @"cancelButton";
static NSString * const kSDJSWebDialogScriptNeutralButtonKey = @"neutralButton";
static NSString * const kSDJSWebDialogScriptHandleAcceptKey = @"handleAccept";
static NSString * const kSDJSWebDialogScriptActionKey = @"action";
static NSString * const kSDJSWebDialogScriptDataKey = @"data";

static NSString * const kSDJSWebDialogActionTypeOk = @"ok";
static NSString * const kSDJSWebDialogActionTypeNeutral = @"neutral";
static NSString * const kSDJSWebDialogActionTypeCancel = @"cancel";

static NSString * const kSDJSWebDialogHandleAcceptScript = @"onAccept();";
static NSString * const kSDJSWebDialogCloseMethodName = @"closeDialog";
static NSString * const kSDJSWebDialogHTMLFormat = @"<html><body class=\"native-dialog ios\">%@</body></html>";

@interface SDJSWebDialogScript ()

@property (nonatomic, copy) SDBridgeHandlerCallbackBlock callback;
@property (nonatomic, assign) BOOL shouldHandleAccept;
@property (nonatomic, weak) SDWebViewController *modalWebViewController;

@end

@implementation SDJSWebDialogScript

#pragma mark - Tap Events

- (void)cancelButtonTapped:(id)sender {
    [self triggerAction:kSDJSWebDialogActionTypeCancel data:nil];

}

- (void)okayButtonTapped:(id)sender {
    if (self.shouldHandleAccept) {
        [self.modalWebViewController evaluateScript:kSDJSWebDialogHandleAcceptScript];
        return;
    }

    [self triggerAction:kSDJSWebDialogActionTypeOk data:nil];
}

#pragma mark - Actions

- (void)triggerAction:(NSString *)action data:(NSString *)data {
    [self.webViewController dismissViewControllerAnimated:YES completion:nil];

    if (self.callback) {
        self.callback(@{kSDJSWebDialogScriptActionKey : action,
                        kSDJSWebDialogScriptDataKey : data ?: [NSNull null]});
    }
}

#pragma mark - External API

- (void)showWebDialogWithOptions:(NSDictionary *)options callback:(SDBridgeHandlerCallbackBlock)callback {
    self.callback = [callback copy];
    
    NSString *title = options[kSDJSWebDialogScriptTitleKey];
    NSString *body = options[kSDJSWebDialogScriptBodyKey];
    NSString *cancelTitle = options[kSDJSWebDialogScriptCancelButtonKey];
    NSString *okTitle = options[kSDJSWebDialogScriptOkButtonKey];
    self.shouldHandleAccept = [options[kSDJSWebDialogScriptHandleAcceptKey] boolValue];
    
    @strongify(self.webViewController, strongWebViewController);
    
    NSString *html = [NSString stringWithFormat:kSDJSWebDialogHTMLFormat, body];
    SDWebViewController *modalWebViewController = [strongWebViewController presentModalHTML:html title:title];
    
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
    
    [modalWebViewController addScriptMethod:kSDJSWebDialogCloseMethodName block:^(NSString *action, NSString *data) {
        [self triggerAction:action data:data];
    }];
    
    self.modalWebViewController = modalWebViewController;
}

@end
