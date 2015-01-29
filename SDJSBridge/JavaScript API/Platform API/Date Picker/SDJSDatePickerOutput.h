//
//  SDJSDatePickerOutput.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/29/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol SDJSDatePickerOutputExports <JSExport>

@property (nonatomic, copy, readonly) NSNumber *year;
@property (nonatomic, copy, readonly) NSNumber *month;
@property (nonatomic, copy, readonly) NSNumber *day;
@property (nonatomic, copy, readonly) NSString *action;

@end

/**
 Encapsulates the output of the date picker script.
 */
@interface SDJSDatePickerOutput : NSObject <SDJSDatePickerOutputExports>

@property (nonatomic, copy, readonly) NSString *action;

- (instancetype)initWithDate:(NSDate *)date cancelled:(BOOL)cancelled;

@end
