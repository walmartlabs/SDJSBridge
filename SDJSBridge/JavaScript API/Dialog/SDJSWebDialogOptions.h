//
//  SDJSWebDialogOptions.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/7/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import "SDJSDialogOptions.h"

@interface SDJSWebDialogOptions : SDJSDialogOptions

@property (nonatomic, copy, readonly) NSString *body;
@property (nonatomic, assign, readonly) BOOL shouldHandleAccept;

@end
