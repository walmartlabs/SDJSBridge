//
//  SDJSDatePickerScript.m
//  WMJSRegistryScriptExample
//
//  Created by Angelo Di Paolo on 12/12/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import <IOSShared/IOSShared.h>
#import "SDJSDatePickerScript.h"
#import "SDJSHandlerScript.h"
#import "SDJSDate.h"
#import "SDJSDatePickerOutput.h"

#import <JavaScriptCore/JavaScriptCore.h>

@interface SDJSDatePickerScript ()

@property (nonatomic, strong) SDPickerView *pickerView;
@property (nonatomic, strong) JSValue *callback;

@end

@implementation SDJSDatePickerScript

#pragma mark - Initialization

- (instancetype)init {
    if ((self = [super init])) {
        _delegate = self;
    }
    return self;
}

#pragma mark - SDJSDatePickerScriptDelegate

- (void)presentDatePickerWithDate:(NSDate *)date selectionBlock:(WMJSDatePickerCompletionBlock)selectDate {
    if (!self.pickerView) {
        self.pickerView = [[SDPickerView alloc] init];
    }
    
    [self.pickerView configureAsDatePicker:date datePickerMode:UIDatePickerModeDate completion:selectDate];
    
    [self.pickerView sendActionsForControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - External API

- (void)presentDatePickerWithOptions:(NSDictionary *)options callback:(SDBridgeHandlerOutputBlock)callback {
    
    @strongify(self.delegate, strongDelegate);
    
    if ([strongDelegate respondsToSelector:@selector(presentDatePickerWithDate:selectionBlock:)]) {
        SDJSDate *dateModel = [SDJSDate dateModelWithDictionary:options];
        [strongDelegate presentDatePickerWithDate:[dateModel dateValue] selectionBlock:^(BOOL canceled, NSDate *selectedDate) {
            SDJSDatePickerOutput *pickerOutput = [[SDJSDatePickerOutput alloc] initWithDate:selectedDate cancelled:canceled];
            callback(pickerOutput);
        }];
    }
}

@end
