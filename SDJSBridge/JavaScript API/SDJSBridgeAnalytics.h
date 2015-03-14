//
//  SDJSBridgeAnalytics.h
//  SDJSBridgeExample
//
//  Created by Steven W. Riggins on 3/13/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

// Abstract top level definitions of analytics payload for Bridge.Analytics

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>


@protocol SDJSBridgeAnalyticsExports <JSExport>

@end

@interface SDJSBridgeAnalytics : NSObject <SDJSBridgeAnalyticsExports>

@end
