//
//  SDJSDate.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/15/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import "SDJSDate.h"

NSString * const kSDJSDateYearKey = @"year";
NSString * const kSDJSDatelMonthKey = @"month";
NSString * const kSDJSDateDayKey = @"day";

@interface SDJSDate ()

@property (nonatomic, copy, readwrite) NSNumber *year;
@property (nonatomic, copy, readwrite) NSNumber *month;
@property (nonatomic, copy, readwrite) NSNumber *day;

@end

@implementation SDJSDate

#pragma mark - Static Helpers

+ (instancetype)dateModelWithDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}

+ (instancetype)dateModelWithDate:(NSDate *)date {
    return [[self alloc] initWithDate:date];
}

// The service which validates receipt data when a TC number is used expects the receipt
// date to be in 0 - 11 format.  This version of dataModelWithData accomodates this.  CB-4815
+ (instancetype)dateModelWithDate:(NSDate *)date useBaseZeroMonth:(BOOL)baseZeroMonth {
    SDJSDate *newDate = [[self alloc] initWithDate:date];
    if (baseZeroMonth) {
        newDate.month = [NSNumber numberWithInteger:[newDate.month integerValue] - 1];
    }
    
    return newDate;
}

#pragma mark - Initialization

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if ((self = [super init])) {
        _year = dictionary[kSDJSDateYearKey];
        _month = dictionary[kSDJSDatelMonthKey];
        _day = dictionary[kSDJSDateYearKey];
    }
    
    return self;
}

- (instancetype)initWithDate:(NSDate *)date {
    if ((self = [super init])) {
        if (date == nil) {
            return nil;
        }
        
        NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                                           fromDate:date];
        _year = @([dateComponents year]);
        _month = @([dateComponents month]);
        _day = @([dateComponents day]);
    }
    
    return self;
}

#pragma mark - NSDate

- (NSDate *)dateValue {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    return [formatter dateFromString:[self stringValue]];
}

- (NSString *)stringValue {
    return [NSString stringWithFormat:@"%@/%@/%@", [self.month stringValue], [self.day stringValue], [self.year stringValue]];
}


@end
