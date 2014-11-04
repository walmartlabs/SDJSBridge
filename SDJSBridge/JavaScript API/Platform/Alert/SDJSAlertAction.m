//
//  SDJSAlertAction.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/4/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSAlertAction.h"

@implementation SDJSAlertAction

+ (instancetype)alertActionWithTitle:(NSString *)title callback:(JSValue *)callback {
    SDJSAlertAction *alertAction = [SDJSAlertAction new];
    alertAction.title = title;
    alertAction.callback = callback;
    return alertAction;
}

- (void)itemTapped:(id)sender {
    if (self.callback) {
        // todo: figure out how to call a block instead
        [self.callback callWithArguments:nil];
    }
}

@end
