//
//  SDJSShareAPI.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/12/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSShareAPI.h"

#import "SDWebViewController.h"
#import "SDMacros.h"
#import "SDJSShareService.h"

@implementation SDJSShareAPI

#pragma mark - Initialization

- (instancetype)initWithWebViewController:(SDWebViewController *)webViewController {
    if ((self = [super initWithWebViewController:webViewController])) {
        _delegate = self;
    }
    
    return self;
}

#pragma mark - JavaScript Bridge API

- (void)shareWithURL:(NSURL *)url message:(NSString *)message excludedServices:(NSArray *)excludedServices {
    UIActivityViewController *activityViewController = [self activityViewControllerWithURL:url message:message excludedServices:excludedServices];
    [self presentActivityViewController:activityViewController];
}

#pragma mark - UIActivityViewController

- (UIActivityViewController *)activityViewControllerWithURL:(NSURL *)url message:(NSString *)message excludedServices:(NSArray *)excludedServices {
    NSArray *items = [self activityItemsWithURL:url message:message];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items
                                                                                         applicationActivities:nil];
    
    activityViewController.completionHandler = [self completionHandler];
    
    if (excludedServices) {
        NSArray *excludedTypes = [SDJSShareService activityTypesFromShareServices:excludedServices];;
        activityViewController.excludedActivityTypes = excludedTypes;
    }
    
    return activityViewController;
}

- (NSArray *)activityItemsWithURL:(NSURL *)url message:(NSString *)message {
    @strongify(self.delegate, strongDelegate);
    
    if ([strongDelegate respondsToSelector:@selector(shareBridgeAPIActivityItemsWithURL:message:)]) {
        return [strongDelegate shareBridgeAPIActivityItemsWithURL:url message:message];
    }
    
    return nil;
}

- (NSArray *)applicationActivitiesWithURL:(NSURL *)url message:(NSString *)message {
    @strongify(self.delegate, strongDelegate);
    
    if ([strongDelegate respondsToSelector:@selector(shareBridgeAPIApplicationActivitiesWithURL:message:)]) {
        return [strongDelegate shareBridgeAPIApplicationActivitiesWithURL:url message:message];
    }
    
    return nil;
}

- (UIActivityViewControllerCompletionHandler)completionHandler {
    @strongify(self.delegate, strongDelegate);
    
    if ([strongDelegate respondsToSelector:@selector(shareBridgeAPICompletionHandler)]) {
        return [strongDelegate shareBridgeAPICompletionHandler];
    }
    
    return nil;
}

- (void)presentActivityViewController:(UIActivityViewController *)activityViewController {
    @strongify(self.delegate, strongDelegate);
    
    if ([strongDelegate respondsToSelector:@selector(shareBridgeAPIPresentActivityViewController:)]) {
        [strongDelegate shareBridgeAPIPresentActivityViewController:activityViewController];
    }
}

#pragma mark - SDJSShareAPIDelegate

- (NSArray *)shareBridgeAPIActivityItemsWithURL:(NSURL *)url message:(NSString *)message {
    return @[message, url];
}

- (NSArray *)shareBridgeAPIApplicationActivitiesWithURL:(NSURL *)url message:(NSString *)message {
    return nil;
}

- (UIActivityViewControllerCompletionHandler)shareBridgeAPICompletionHandler {
    return ^(NSString *activityTtpe, BOOL completed) {
        if (completed) {
            // invoke JS callback
            [self performActionWithSender:nil];
        }
    };
}

- (void)shareBridgeAPIPresentActivityViewController:(UIActivityViewController *)activityViewController {
    [self.webViewController presentViewController:activityViewController animated:YES completion:nil];
}

@end
