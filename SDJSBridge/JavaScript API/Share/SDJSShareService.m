//
//  SDJSShareService.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/13/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSShareService.h"

@interface SDJSShareService ()

@property (nonatomic, copy, readwrite) NSString *activityType;

@end

@implementation SDJSShareService

- (instancetype)initWithActivityType:(NSString *)activityType {
    if ((self = [super init])) {
        _activityType = activityType;
    }
    
    return self;
}

+ (SDJSShareService *)facebook {
    return [[SDJSShareService alloc] initWithActivityType:UIActivityTypePostToFacebook];
}

+ (SDJSShareService *)twitter {
    return [[SDJSShareService alloc] initWithActivityType:UIActivityTypePostToTwitter];
}

+ (SDJSShareService *)mail {
    return [[SDJSShareService alloc] initWithActivityType:UIActivityTypeMail];
}

+ (SDJSShareService *)message {
    return [[SDJSShareService alloc] initWithActivityType:UIActivityTypeMessage];
}

+ (SDJSShareService *)flickr {
    return [[SDJSShareService alloc] initWithActivityType:UIActivityTypePostToFlickr];
}

+ (SDJSShareService *)vimeo {
    return [[SDJSShareService alloc] initWithActivityType:UIActivityTypePostToVimeo];
}

@end
