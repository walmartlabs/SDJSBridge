//
//  SDJSShareService.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/13/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol SDJSShareServiceExports <JSExport>

+ (NSString *)Facebook;

@end

@interface SDJSShareService : NSObject <SDJSShareServiceExports>

+ (NSString *)Facebook;

@end
