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
    SDJSAlertAction *alertAction = [[SDJSAlertAction alloc] initWithCallback:callback];
    alertAction.title = title;
    return alertAction;
}

@end
