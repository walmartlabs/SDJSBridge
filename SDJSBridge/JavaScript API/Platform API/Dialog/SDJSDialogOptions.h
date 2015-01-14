//
//  SDJSDialogOptions.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/7/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDJSDialogOptions : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *okButtonTitle;
@property (nonatomic, copy, readonly) NSString *neutralButtonTitle;
@property (nonatomic, copy, readonly) NSString *cancelButtonTitle;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
