//
//  SDJSAlertScript.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/19/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSAlertScript.h"
#import "SDJSAlertButton.h"
#import "SDJSAlertOptions.h"

#import <UIKit/UIKit.h>

static NSString * const kSDJSAlertOptionTitleKey = @"title";
static NSString * const kSDJSAlertOptionMessageKey = @"title";
static NSString * const kSDJSAlertOptionOkButtonKey = @"okButton";
static NSString * const kSDJSAlertOptionCancelButtonKey = @"cancelButton";
static NSString * const kSDJSAlertOptionNeutralButtonKey = @"neutralButton";

@interface SDJSAlertScript ()

@property (nonatomic, copy) NSArray *buttons;
@property (nonatomic, copy) SDBridgeHandlerCallbackBlock callback;

@end

@implementation SDJSAlertScript

#pragma mark - UIAlertView

- (UIAlertView *)showAlertWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray *)buttons {
    self.buttons = buttons;

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    
    for (SDJSAlertButton *button in buttons) {
        [alert addButtonWithTitle:button.title];
    }
    
    if (!buttons.count) {
        [alert addButtonWithTitle:@"OK"];
    }
        
    [alert show];
    return alert;
}

- (UIAlertView *)showAlertWithAlertOptions:(SDJSAlertOptions *)alertOptions {
    NSMutableArray *buttons = [[NSMutableArray alloc] init];
    
    if (alertOptions.cancelButtonTitle) {
        [buttons addObject:[SDJSAlertButton alertButtonWithTitle:alertOptions.cancelButtonTitle type:SDJSAlertButtonTypeCancel]];
    }
    if (alertOptions.neutralButtonTitle) {
        [buttons addObject:[SDJSAlertButton alertButtonWithTitle:alertOptions.neutralButtonTitle type:SDJSAlertButtonTypeNeutral]];
    }
    if (alertOptions.okButtonTitle) {
        [buttons addObject:[SDJSAlertButton alertButtonWithTitle:alertOptions.okButtonTitle type:SDJSAlertButtonTypeOk]];
    }
    
    return [self showAlertWithTitle:alertOptions.title message:alertOptions.message buttons:buttons];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    SDJSAlertButton *button = self.buttons[(NSUInteger)buttonIndex];
    
    if (self.callback) {
        self.callback([button actionType]);
    }
}

#pragma mark - External API

- (void)showAlertWithOptions:(NSDictionary *)options callback:(SDBridgeHandlerCallbackBlock)callback {
    self.callback = [callback copy];
    
    SDJSAlertOptions *alertOptions = [[SDJSAlertOptions alloc] initWithDictionary:options];
    [self showAlertWithAlertOptions:alertOptions];
}

@end
