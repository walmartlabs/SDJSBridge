//
//  SDJSAlertOptions.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/7/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import "SDJSAlertOptions.h"

static NSString * const kSDJSAlertOptionsMessageKey = @"message";

@implementation SDJSAlertOptions

#pragma mark - Initialization

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if ((self = [super initWithDictionary:dictionary])) {
        _message = dictionary[kSDJSAlertOptionsMessageKey];
    }
    
    return self;
}
@end
