//
//  SDJSShareAPI.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/12/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeResponder.h"

#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>

@protocol SDJSShareAPIDelegate <NSObject>

- (NSArray *)shareBridgeAPIActivityItems;
- (void)shareBridgeAPIPresentActivityViewController:(UIActivityViewController *)activityViewController;
- (UIActivityViewControllerCompletionHandler)shareBridgeAPICompletionHandler;

@end

@interface SDJSShareAPI : SDJSBridgeResponder

- (void)shareWithURL:(NSURL *)url message:(NSString *)message;

@end
