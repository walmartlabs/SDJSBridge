//
//  SDJSAlertScript.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/19/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSAlertScript.h"
#import "SDJSAlertButton.h"

#import <UIKit/UIKit.h>

NSString * const SDJSAlertOptionTitleKey = @"title";
NSString * const SDJSAlertOptionMessageKey = @"title";
NSString * const SDJSAlertOptionOkButtonKey = @"okButton";
NSString * const SDJSAlertOptionCancelButtonKey = @"cancelButton";
NSString * const SDJSAlertOptionNeutralButtonKey = @"neutralButton";

@interface SDJSAlertScript ()

@property (nonatomic, copy) NSArray *buttons;
@property (nonatomic, copy) SDBridgeHandlerCallbackBlock callback;

@end

@implementation SDJSAlertScript

#pragma mark - Alerts

- (UIAlertView *)showAlert:(NSString *)title message:(NSString *)message buttons:(NSArray *)buttons {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    
    for (SDJSAlertButton *button in buttons) {
        [alert addButtonWithTitle:button.title];
    }
    
    if (!buttons.count) {
        [alert addButtonWithTitle:@"OK"];
    }
    
    self.buttons = buttons;
    
    [alert show];
    return alert;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    SDJSAlertButton *button = self.buttons[(NSUInteger)buttonIndex];
    NSLog(@"%@", [button actionType]);
    
    if (self.callback) {
        self.callback([button actionType]);
    }
}

#pragma mark - External API

- (void)showAlertWithOptions:(NSDictionary *)options callback:(SDBridgeHandlerCallbackBlock)callback {
    self.callback = [callback copy];
    
    NSString *title = options[SDJSAlertOptionTitleKey];
    NSString *message = options[SDJSAlertOptionMessageKey];
    NSString *okButtonTitle = options[SDJSAlertOptionOkButtonKey];
    NSString *cancelButtonTitle = options[SDJSAlertOptionCancelButtonKey];
    NSString *neutralButtonTitle = options[SDJSAlertOptionNeutralButtonKey];

    NSMutableArray *buttons = [[NSMutableArray alloc] init];

    if ([cancelButtonTitle isKindOfClass:[NSString class]]) {
        [buttons addObject:[SDJSAlertButton alertButtonWithTitle:cancelButtonTitle type:SDJSAlertButtonTypeCancel]];
    }
    if ([neutralButtonTitle isKindOfClass:[NSString class]]) {
        [buttons addObject:[SDJSAlertButton alertButtonWithTitle:neutralButtonTitle type:SDJSAlertButtonTypeNeutral]];
    }
    if ([okButtonTitle isKindOfClass:[NSString class]]) {
        [buttons addObject:[SDJSAlertButton alertButtonWithTitle:okButtonTitle type:SDJSAlertButtonTypeOk]];
    }
    
    [self showAlert:title message:message buttons:buttons];
}

@end
