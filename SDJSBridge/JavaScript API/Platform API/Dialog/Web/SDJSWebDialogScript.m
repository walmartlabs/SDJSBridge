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
#import "SDJSScriptOutput.h"

static NSString * const kSDJSWebDialogScriptActionKey = @"action";
static NSString * const kSDJSWebDialogScriptDataKey = @"data";
static NSString * const kSDJSWebDialogHandleAcceptScript = @"onAccept();";
static NSString * const kSDJSWebDialogCloseMethodName = @"closeDialog";

@interface SDJSWebDialogScript ()

@property (nonatomic, copy) SDBridgeHandlerOutputBlock callback;
@property (nonatomic, assign) BOOL shouldHandleAccept;
@property (nonatomic, weak) SDWebViewController *modalWebViewController;

@end

@implementation SDJSWebDialogScript

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

#pragma mark - Tap Events

- (void)cancelButtonTapped:(id)sender {
    [self dismissDialogWithCancelled:YES data:nil];
}

- (void)okayButtonTapped:(id)sender {
    [self dismissDialogWithCancelled:NO data:nil];
}

#pragma mark - Dismissing Modal Web Dialog

- (void)dismissDialogWithCancelled:(BOOL)cancelled data:(NSString *)data {
    if (self.shouldHandleAccept && !cancelled) {
        [self.modalWebViewController evaluateScript:kSDJSWebDialogHandleAcceptScript];
        return;
    }
    
    [self triggerAction:[SDJSScriptOutput actionValueForCancelled:cancelled] data:data];
}

#pragma mark - Action

- (void)triggerAction:(NSString *)action data:(NSString *)data {
    [self.webViewController dismissViewControllerAnimated:YES completion:nil];

    if (self.callback) {
        self.callback(@{kSDJSWebDialogScriptActionKey : action,
                        kSDJSWebDialogScriptDataKey : data ?: [NSNull null]});
    }
}

#pragma mark - External API

- (void)showWebDialogWithOptions:(NSDictionary *)options callback:(SDBridgeHandlerOutputBlock)callback {
    self.callback = [callback copy];
    
    SDJSWebDialogOptions *dialogOptions = [[SDJSWebDialogOptions alloc] initWithDictionary:options];
    [self showWebDialogWithDialogOptions:dialogOptions];
}

@end
