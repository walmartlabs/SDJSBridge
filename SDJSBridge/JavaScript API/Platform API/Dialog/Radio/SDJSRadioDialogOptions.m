//
//  SDJSRadioDialogOptions.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/8/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import "SDJSRadioDialogOptions.h"

static NSString * const kSDJSRadioDialogOptionsSelectedItemKey = @"selectedItem";
static NSString * const kSDJSRadioDialogOptionsItemsKey = @"items";

@implementation SDJSRadioDialogOptions

#pragma mark - Initialization

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if ((self = [super initWithDictionary:dictionary])) {
        _items = dictionary[kSDJSRadioDialogOptionsItemsKey];
        _selectedItem = [dictionary[kSDJSRadioDialogOptionsSelectedItemKey] integerValue];
    }
    
    return self;
}

@end
