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
static NSString * const kSDJSSDJSScriptOutputNeutralAction = @"neutral";

@implementation SDJSScriptOutput

#pragma mark - Actions

+ (NSString *)actionValueForCancelled:(BOOL)cancelled {
    return cancelled ? kSDJSSDJSScriptOutputCancelAction : kSDJSScriptOutputSuccessAction;
}

+ (NSString *)successActionValue {
    return kSDJSScriptOutputSuccessAction;
}

+ (NSString *)cancelActionValue {
    return kSDJSSDJSScriptOutputCancelAction;
}

+ (NSString *)neutralActionValue {
    return kSDJSSDJSScriptOutputNeutralAction;
}

@end
