//
//  SDJSDialogOptions.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/7/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import "SDJSDialogOptions.h"

static NSString * const kSDJSDialogOptionsTitleKey = @"title";
static NSString * const kSDJSDialogOptionsOkayButtonKey = @"okButton";
static NSString * const kSDJSDialogOptionsCancelButtonKey = @"cancelButton";
static NSString * const kSDJSDialogOptionsNeutralButtonKey = @"neutralButton";

@implementation SDJSDialogOptions

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if ((self = [super init])) {
        _title = kSDJSDialogOptionsTitleKey;
        _okButtonTitle = kSDJSDialogOptionsOkayButtonKey;
        _cancelButtonTitle = kSDJSDialogOptionsCancelButtonKey;
        _neutralButtonTitle = kSDJSDialogOptionsNeutralButtonKey;
    }
    
    return self;
}

@end
