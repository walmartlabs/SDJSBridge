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
#import "SDJSWebDialogOptions.h"

static NSString * const kSDJSWebDialogScriptActionKey = @"action";
static NSString * const kSDJSWebDialogScriptDataKey = @"data";

static NSString * const kSDJSWebDialogActionTypeOk = @"ok";
static NSString * const kSDJSWebDialogActionTypeNeutral = @"neutral";
static NSString * const kSDJSWebDialogActionTypeCancel = @"cancel";

static NSString * const kSDJSWebDialogHandleAcceptScript = @"onAccept();";
static NSString * const kSDJSWebDialogCloseMethodName = @"closeDialog";

@interface SDJSWebDialogScript ()

@property (nonatomic, copy) SDBridgeHandlerOutputBlock callback;
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

#pragma mark - Presenting Modal Web Dialog

- (void)showWebDialogWithDialogOptions:(SDJSWebDialogOptions *)dialogOptions {
    self.shouldHandleAccept = dialogOptions.shouldHandleAccept;
    
    @strongify(self.webViewController, strongWebViewController);
    
    SDWebViewController *modalWebViewController = [strongWebViewController presentModalHTML:dialogOptions.content title:dialogOptions.title];
    
    if (dialogOptions.cancelButtonTitle) {
        modalWebViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:dialogOptions.cancelButtonTitle
                                                                                                   style:UIBarButtonItemStylePlain
                                                                                                  target:self
                                                                                                  action:@selector(cancelButtonTapped:)];
    }
    
    if (dialogOptions.okButtonTitle) {
        modalWebViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:dialogOptions.okButtonTitle
                                                                                                    style:UIBarButtonItemStylePlain
                                                                                                   target:self
                                                                                                   action:@selector(okayButtonTapped:)];
    }
    
    [modalWebViewController addScriptMethod:kSDJSWebDialogCloseMethodName block:^(NSString *action, NSString *data) {
        [self triggerAction:action data:data];
    }];
    
    self.modalWebViewController = modalWebViewController;
}

#pragma mark - External API

- (void)showWebDialogWithOptions:(NSDictionary *)options callback:(SDBridgeHandlerOutputBlock)callback {
    self.callback = [callback copy];
    
    SDJSWebDialogOptions *dialogOptions = [[SDJSWebDialogOptions alloc] initWithDictionary:options];
    [self showWebDialogWithDialogOptions:dialogOptions];
}

@end
