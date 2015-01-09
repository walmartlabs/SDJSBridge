//
//  SDJSBridgeInfo.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/9/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import "SDJSBridgeInfo.h"

#import <UIKit/UIKit.h>

@implementation SDJSBridgeInfo

- (instancetype)initWithAPILevel:(NSUInteger)apiLevel {
    if ((self = [super init])) {
        _apiLevel = apiLevel;
        
        UIDevice *currentDevice = [UIDevice currentDevice];
        _osName = currentDevice.systemName;
        _osVersion = currentDevice.systemVersion;
    }
    
    return self;
}

@end
