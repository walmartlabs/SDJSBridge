//
//  SDJSPlatformAPI.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 10/30/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSPlatformAPI.h"
#import "SDJSNavigationAPI.h"

@implementation SDJSPlatformAPI

#pragma mark - Initialization

- (instancetype)init {
    if ((self = [super init])) {
        _navigation = [[SDJSNavigationAPI alloc] initWithPlatform:self];
    }
    
    return self;
}

@end
