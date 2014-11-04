//
//  SDJSNavigationItemAPI.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/3/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSNavigationItemAPI.h"

#import "SDJSNavigationItem.h"

@implementation SDJSNavigationItemAPI

- (SDJSNavigationItem *)navigationItemWithTitle:(NSString *)title
                                      imageName:(NSString *)imageName
                                       callback:(SDJSNavigationItemCallback)callback {
    SDJSNavigationItem *navigationItem = [SDJSNavigationItem new];
    navigationItem.title = title;
    navigationItem.imageName = imageName;
    navigationItem.callback = callback;
    return nil;
}

@end
