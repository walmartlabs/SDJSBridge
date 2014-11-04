//
//  SDJSNavigationItem.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/3/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSNavigationItem.h"

@implementation SDJSNavigationItem

+ (instancetype)navigationItemWithTitle:(NSString *)title imageName:(NSString *)imageName callback:(JSValue *)callback {
    SDJSNavigationItem *navigationItem = [SDJSNavigationItem new];
    navigationItem.title = title;
    navigationItem.imageName = imageName;
    navigationItem.callback = callback;
    return navigationItem;
}

- (void)itemTapped:(id)sender {
    if (self.callback) {
        // todo: figure out how to call a block instead
        [self.callback callWithArguments:nil];
    }
}

@end
