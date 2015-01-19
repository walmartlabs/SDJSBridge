//
//  SDJSDatePickerScript.m
//  WMJSRegistryScriptExample
//
//  Created by Angelo Di Paolo on 12/12/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSDatePickerScript.h"
#import "SDPickerView.h"
#import "SDMacros.h"
#import "SDJSHandlerScript.h"
#import "SDJSDate.h"

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
    
    [self.pickerView configureAsDatePicker:date completion:^(BOOL canceled, NSDate *selectedDate) {
        selectDate(selectedDate);
    }];
    
    [self.pickerView sendActionsForControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - External API

- (void)presentDatePickerWithOptions:(NSDictionary *)options callback:(SDBridgeHandlerOutputBlock)callback {
    
    @strongify(self.delegate, strongDelegate);
    
    if ([strongDelegate respondsToSelector:@selector(presentDatePickerWithDate:selectionBlock:)]) {
        SDJSDate *dateModel = [SDJSDate dateModelWithDictionary:options];
        [strongDelegate presentDatePickerWithDate:[dateModel dateValue] selectionBlock:^(NSDate *selectedDate) {
            SDJSDate *selectedDateModel = [SDJSDate dateModelWithDate:selectedDate];
            callback(selectedDateModel);
        }];
    }
}

@end
