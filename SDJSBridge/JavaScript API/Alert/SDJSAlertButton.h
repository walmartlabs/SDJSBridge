//
//  SDJSAlertButton.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/22/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ENUM(NSInteger, SDJSAlertButtonType) {
    SDJSAlertButtonTypeOk,
    SDJSAlertButtonTypeCancel,
    SDJSAlertButtonTypeNeutral
};

@interface SDJSAlertButton : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign, readonly) NSInteger buttonType;

+ (instancetype)alertButtonWithTitle:(NSString *)title type:(enum SDJSAlertButtonType)buttonType;
- (instancetype)initWithTitle:(NSString *)title type:(enum SDJSAlertButtonType)buttonType;
- (NSString *)actionType;

@end
