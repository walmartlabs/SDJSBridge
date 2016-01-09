//
//  SDJSDate.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/15/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol SDJSDateExports <JSExport>

@property (nonatomic, copy, readonly) NSNumber *year;
@property (nonatomic, copy, readonly) NSNumber *month;
@property (nonatomic, copy, readonly) NSNumber *day;

@end

@interface SDJSDate : NSObject <SDJSDateExports>

@property (nonatomic, copy, readonly) NSNumber *year;
@property (nonatomic, copy, readonly) NSNumber *month;
@property (nonatomic, copy, readonly) NSNumber *day;

+ (instancetype)dateModelWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)dateModelWithDate:(NSDate *)date;
+ (instancetype)dateModelWithDate:(NSDate *)date useBaseZeroMonth:(BOOL)baseZeroMonth;
- (NSDate *)dateValue;

@end
