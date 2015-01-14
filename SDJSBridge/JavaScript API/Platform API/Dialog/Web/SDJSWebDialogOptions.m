//
//  SDJSWebDialogOptions.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/7/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import "SDJSWebDialogOptions.h"

static NSString * const kSDJSWebDialogOptionsContentKey = @"content";
static NSString * const kSDJSWebDialogOptionsHandleAcceptKey = @"handleAccept";

@implementation SDJSWebDialogOptions

#pragma mark - Initialization

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if ((self = [super initWithDictionary:dictionary])) {
        _shouldHandleAccept = [dictionary[kSDJSWebDialogOptionsHandleAcceptKey] boolValue];
        _content = dictionary[kSDJSWebDialogOptionsContentKey];
    }
    
    return self;
}

@end
