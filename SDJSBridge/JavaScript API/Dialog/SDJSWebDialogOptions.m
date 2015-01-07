//
//  SDJSWebDialogOptions.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/7/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import "SDJSWebDialogOptions.h"

static NSString * const SDJSWebDialogOptionsBodyKey = @"body";
static NSString * const SDJSWebDialogOptionsHandleAcceptKey = @"handleAccept";

@implementation SDJSWebDialogOptions

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if ((self = [super initWithDictionary:dictionary])) {
        _shouldHandleAccept = [dictionary[SDJSWebDialogOptionsHandleAcceptKey] boolValue];
        _body = dictionary[SDJSWebDialogOptionsBodyKey];
    }
    
    return self;
}

@end
