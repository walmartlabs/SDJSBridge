//
//  SDJSTopLevelAPI.m
//  SDJSBridge
//
//  Created by Brandon Sneed on 9/22/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSTopLevelAPI.h"

@implementation SDJSTopLevelAPI

#pragma mark - Initialization

- (instancetype)init {
    if ((self = [super init])) {
        _platform = [[SDJSPlatformAPI alloc] init];
    }
    
    return self;
}

@end
