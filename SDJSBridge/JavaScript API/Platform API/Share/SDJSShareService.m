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

#pragma mark - Initialization

- (instancetype)initWithActivityType:(NSString *)activityType {
    if ((self = [super init])) {
        _activityType = activityType;
    }
    
    return self;
}

#pragma mark - Services

+ (NSDictionary *)allServices {
    return @{@"Facebook" : [SDJSShareService facebook],
             @"Mail" : [SDJSShareService mail],
             @"Twitter" : [SDJSShareService twitter],
             @"Message" : [SDJSShareService message],
             @"Flickr" : [SDJSShareService flickr],
             @"Vimeo" : [SDJSShareService vimeo]};
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

+ (NSArray *)activityTypesFromShareServices:(NSArray *)shareServices {
    if (shareServices) {
        NSMutableArray *excludedTypes = [NSMutableArray array];
        
        for (SDJSShareService *service in shareServices) {
            if ([service isKindOfClass:[SDJSShareService class]]) {
                [excludedTypes addObject:service.activityType];
            }
        }
        
        return [excludedTypes copy];
    }
    
    return nil;
}

@end
