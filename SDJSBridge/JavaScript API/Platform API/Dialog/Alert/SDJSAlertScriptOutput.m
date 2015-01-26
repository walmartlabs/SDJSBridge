//
//  SDJSAlertScriptOutput.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/26/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import "SDJSAlertScriptOutput.h"

@implementation SDJSAlertScriptOutput

- (instancetype)initWithAction:(NSString *)action {
    if ((self = [super init])) {
        _action = action;
    }
    
    return self;
}

@end
