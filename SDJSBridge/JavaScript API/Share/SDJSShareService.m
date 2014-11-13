//
//  SDJSShareService.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/13/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSShareService.h"

NSString * const SDJSShareServiceMessage = @"SDJSShareServiceMessage";
NSString * const SDJSShareServiceMail = @"SDJSShareServiceMail";
NSString * const SDJSShareServiceFlickr = @"SDJSShareServiceFlickr";
NSString * const SDJSShareServiceVimeo = @"SDJSShareServiceVimeo";
NSString * const SDJSShareServiceFacebook = @"SDJSShareServiceFacebook";
NSString * const SDJSShareServiceTwitter = @"SDJSShareServiceTwitter";

@interface SDJSShareService ()

@property (nonatomic, copy) NSString *serviceType;

@end

@implementation SDJSShareService

- (instancetype)initWithServiceType:(NSString *)serviceType {
    if ((self = [super init])) {
        _serviceType = serviceType;
    }
    
    return self;
}

+ (SDJSShareService *)facebook {
    return [[SDJSShareService alloc] initWithServiceType:SDJSShareServiceFacebook];
}

@end
