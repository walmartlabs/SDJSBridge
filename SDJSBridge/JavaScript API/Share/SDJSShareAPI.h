//
//  SDJSShareAPI.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/12/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeResponder.h"

#import <JavaScriptCore/JavaScriptCore.h>

@interface SDJSShareAPI : SDJSBridgeResponder

- (void)shareWithURL:(NSURL *)url message:(NSString *)message callback:(JSValue *)callback;

@end
