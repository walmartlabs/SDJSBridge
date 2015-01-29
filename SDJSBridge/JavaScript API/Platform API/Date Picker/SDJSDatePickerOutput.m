//
//  SDJSDatePickerOutput.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/29/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import "SDJSDatePickerOutput.h"
#import "SDJSDate.h"

static NSString * const kSDJSDatePickerOutputSuccessAction = @"ok";
static NSString * const kSDJSDatePickerOutputCancelAction = @"cancel";

@interface SDJSDatePickerOutput ()

@property (nonatomic, strong) SDJSDate *jsDate;

@end

@implementation SDJSDatePickerOutput

#pragma mark - Initialization

- (instancetype)initWithDate:(NSDate *)date cancelled:(BOOL)cancelled {
    if ((self = [super init])) {
        _jsDate = [SDJSDate dateModelWithDate:date];
        _action = cancelled ? kSDJSDatePickerOutputCancelAction : kSDJSDatePickerOutputSuccessAction;
    }
    
    return self;
}

#pragma mark - SDJSDatePickerOutputExports

- (NSNumber *)year {
    return self.jsDate.year;
}

- (NSNumber *)month {
    return self.jsDate.month;
}

- (NSNumber *)day {
    return self.jsDate.day;
}


@end
