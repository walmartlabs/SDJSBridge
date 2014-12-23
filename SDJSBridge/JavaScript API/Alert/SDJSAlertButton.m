//
//  SDJSAlertButton.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/22/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSAlertButton.h"

NSString * const SDJSAlertButtonActionTypeOk = @"ok";
NSString * const SDJSAlertButtonActionTypeNeutral = @"neutral";
NSString * const SDJSAlertButtonActionTypeCancel = @"cancel";

@implementation SDJSAlertButton

+ (instancetype)alertButtonWithTitle:(NSString *)title type:(enum SDJSAlertButtonType)buttonType {
    return [[self alloc] initWithTitle:title type:buttonType];
}

- (instancetype)initWithTitle:(NSString *)title type:(enum SDJSAlertButtonType)buttonType {
    if ((self = [super init])) {
        _title = title;
        _buttonType = buttonType;
    }
    
    return self;
}

- (NSString *)actionType {
    switch (self.buttonType) {
        case SDJSAlertButtonTypeCancel:
            return SDJSAlertButtonActionTypeCancel;
            break;
        case SDJSAlertButtonTypeNeutral:
            return SDJSAlertButtonActionTypeNeutral;
            break;
        case SDJSAlertButtonTypeOk:
            return SDJSAlertButtonActionTypeOk;
            break;
        default:
            return nil;
            break;
    }
    
    return nil;
}

@end
