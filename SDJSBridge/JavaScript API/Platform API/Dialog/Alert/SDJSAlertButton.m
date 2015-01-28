//
//  SDJSAlertButton.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/22/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSAlertButton.h"

static NSString * const kSDJSAlertButtonActionTypeOk = @"ok";
static NSString * const kSDJSAlertButtonActionTypeNeutral = @"neutral";
static NSString * const kSDJSAlertButtonActionTypeCancel = @"cancel";

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
            return kSDJSAlertButtonActionTypeCancel;
            break;
        case SDJSAlertButtonTypeNeutral:
            return kSDJSAlertButtonActionTypeNeutral;
            break;
        case SDJSAlertButtonTypeOk:
            return kSDJSAlertButtonActionTypeOk;
            break;
        default:
            return nil;
            break;
    }
    
    return nil;
}

@end
