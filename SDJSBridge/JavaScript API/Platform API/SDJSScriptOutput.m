//
//  SDJSScriptOutput.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/29/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import "SDJSScriptOutput.h"

static NSString * const kSDJSScriptOutputSuccessAction = @"ok";
static NSString * const kSDJSSDJSScriptOutputCancelAction = @"cancel";

@implementation SDJSScriptOutput

+ (NSString *)actionForCancelled:(BOOL)cancelled {
    return cancelled ? kSDJSSDJSScriptOutputCancelAction : kSDJSScriptOutputSuccessAction;
}

@end
