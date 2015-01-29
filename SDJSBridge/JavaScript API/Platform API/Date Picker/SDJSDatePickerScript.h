//
//  SDJSDatePickerScript.h
//  WMJSRegistryScriptExample
//
//  Created by Angelo Di Paolo on 12/12/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSHandlerScript.h"

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

typedef void(^WMJSDatePickerCompletionBlock)(BOOL canceled, NSDate *selectedDate);

@protocol SDJSDatePickerScriptDelegate <NSObject>

- (void)presentDatePickerWithDate:(NSDate *)date selectionBlock:(WMJSDatePickerCompletionBlock)selectDate;

@end

@protocol SDJSDatePickerScriptExports <JSExport>

JSExportAs(datePicker, - (void)presentDatePickerWithOptions:(NSDictionary *)options callback:(JSValue *)callback);

@end

@interface SDJSDatePickerScript : NSObject <SDJSDatePickerScriptDelegate>

@property (nonatomic, weak) id<SDJSDatePickerScriptDelegate>delegate;

- (void)presentDatePickerWithOptions:(NSDictionary *)options callback:(SDBridgeHandlerOutputBlock)callback;

@end
