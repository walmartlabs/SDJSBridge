//
//  SDJSDatePickerOutput.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/29/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import "SDJSDatePickerOutput.h"
#import "SDJSDate.h"
#import "SDJSScriptOutput.h"

@interface SDJSDatePickerOutput ()

@property (nonatomic, strong) SDJSDate *jsDate;

@end

@implementation SDJSDatePickerOutput

#pragma mark - Initialization

- (instancetype)initWithDate:(NSDate *)date cancelled:(BOOL)cancelled {
    if ((self = [super init])) {
        _jsDate = [SDJSDate dateModelWithDate:date];
        _action = [SDJSScriptOutput actionForCancelled:cancelled];
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
