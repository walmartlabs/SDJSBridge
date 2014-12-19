//
//  SDJSAlertScript.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/19/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSAlertScript.h"
#import "SDJSAlertAction.h"

#import <UIKit/UIKit.h>

@interface SDJSAlertScript ()

@property (nonatomic, copy) NSArray *actions;
@property (nonatomic, copy) SDBridgeHandlerCallbackBlock callback;

@end

@implementation SDJSAlertScript

#pragma mark - Alerts

- (SDJSAlertAction *)alertActionWithTitle:(NSString *)title callback:(JSValue *)callback {
    return [SDJSAlertAction alertActionWithTitle:title callback:callback];
}

- (UIAlertView *)showAlert:(NSString *)title message:(NSString *)message actions:(NSArray *)actions {
    self.actions = actions;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    
    for (SDJSAlertAction *action in self.actions) {
        [alert addButtonWithTitle:action.title];
    }
    
    if (!self.actions.count) {
        [alert addButtonWithTitle:@"OK"];
    }
    
    [alert show];
    return alert;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    SDJSAlertAction *action = self.actions[(NSUInteger)buttonIndex];
//    
//    if (action) {
//        [action runCallbackWithSender:alertView];
//    }
    
    if (self.callback) {
        self.callback(nil);
    }
}


#pragma mark - SDJSBridgeHandler

- (NSString *)handlerName {
    return @"alert";
}

- (void)callHandlerWithData:(JSValue *)data callback:(SDBridgeHandlerCallbackBlock)callback {
    self.callback = [callback copy];
    
    NSDictionary *object = [data toObject];
    NSString *title = object[@"title"];
    NSString *message = object[@"message"];
    
    [self showAlert:title message:message actions:nil];
}

@end
