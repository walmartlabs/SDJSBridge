//
//  SDJSRadioDialogOptions.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/8/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import "SDJSDialogOptions.h"

@interface SDJSRadioDialogOptions : SDJSDialogOptions

@property (nonatomic, copy, readonly) NSArray *items;
@property (nonatomic, assign, readonly) NSInteger selectedItem;

@end
