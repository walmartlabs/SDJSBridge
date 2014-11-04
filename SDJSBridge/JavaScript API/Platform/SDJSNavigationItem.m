//
//  SDJSNavigationItem.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/3/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSNavigationItem.h"

@implementation SDJSNavigationItem

- (void)itemTapped:(id)sender {
    if (self.callback) {
        // todo: figure out how to call a block instead
        [self.callback callWithArguments:nil];
    }
}

@end
