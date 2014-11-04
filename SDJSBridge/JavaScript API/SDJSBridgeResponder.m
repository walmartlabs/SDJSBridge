//
//  SDJSBridgeResponder.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/4/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeResponder.h"

@implementation SDJSBridgeResponder

- (instancetype)initWithCallback:(JSValue *)callback {
    if ((self = [super init])) {
        _callback = callback;
    }
    
    return self;
}

- (void)performActionWithSender:(id)sender {
    if (self.callback) {
        [self.callback callWithArguments:nil];
    }
}

- (SEL)actionSelector {
    return @selector(performActionWithSender:);
}

@end
