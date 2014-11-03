//
//  SDJSBridgeScript.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/3/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SDWebViewController;

@interface SDJSBridgeScript : NSObject

@property (nonatomic, weak, readonly) SDWebViewController *webViewController;

- (instancetype)initWithWebViewController:(SDWebViewController *)webViewController;

@end
