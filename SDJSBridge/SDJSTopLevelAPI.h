//
//  SDJSTopLevelAPI.h
//  SDJSBridge
//
//  Created by Brandon Sneed on 9/22/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDJSPlatformAPI.h"

@protocol SDJSTopLevelAPIExports <JSExport>
@property (nonatomic, strong) SDJSPlatformAPI *platform;
@end

@interface SDJSTopLevelAPI : NSObject<SDJSTopLevelAPIExports>
@property (nonatomic, strong) SDJSPlatformAPI *platform;
@end
