//
//  SDJSShareAPI.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/12/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSShareAPI.h"

#import "SDWebViewController.h"

@implementation SDJSShareAPI

- (void)shareWithURL:(NSURL *)url message:(NSString *)message {
    NSArray *items = @[message, url];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items
                                                                                         applicationActivities:nil];
    
    activityViewController.completionHandler = ^(NSString *activityTtpe, BOOL completed) {
        if (completed) {
            // invoke JS callback
            [self performActionWithSender:nil];
        }
    };
    
    [self.webViewController presentViewController:activityViewController animated:YES completion:nil];
}

@end
