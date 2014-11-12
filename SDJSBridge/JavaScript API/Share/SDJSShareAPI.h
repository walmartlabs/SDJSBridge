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

@optional

- (NSArray *)shareBridgeAPIActivityItemsWithURL:(NSURL *)url message:(NSString *)message;
- (NSArray *)shareBridgeAPIApplicationActivitiesWithURL:(NSURL *)url message:(NSString *)message;
- (void)shareBridgeAPIPresentActivityViewController:(UIActivityViewController *)activityViewController;
- (UIActivityViewControllerCompletionHandler)shareBridgeAPICompletionHandler;

@end

@interface SDJSShareAPI : SDJSBridgeResponder <SDJSShareAPIDelegate>

@property (nonatomic, weak) id<SDJSShareAPIDelegate> delegate;

- (void)shareWithURL:(NSURL *)url message:(NSString *)message;

@end
