//
//  SDJSShareScript.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/12/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSShareScript.h"

#import "SDWebViewController.h"
#import "SDMacros.h"
#import "SDJSShareService.h"

NSString * const SDJSShareScriptMessageKey = @"message";
NSString * const SDJSShareScriptURLKey = @"url";

@implementation SDJSShareScript

#pragma mark - Initialization

- (instancetype)initWithWebViewController:(SDWebViewController *)webViewController {
    if ((self = [super initWithWebViewController:webViewController])) {
        _delegate = self;
    }
    
    return self;
}

#pragma mark - JavaScript Bridge API

- (UIActivityViewController *)shareURL:(NSURL *)url message:(NSString *)message excludedServices:(NSArray *)excludedServices {
    UIActivityViewController *activityViewController = [self activityViewControllerWithURL:url message:message excludedServices:excludedServices];
    [self presentActivityViewController:activityViewController];
    return activityViewController;
}

#pragma mark - UIActivityViewController

- (UIActivityViewController *)activityViewControllerWithURL:(NSURL *)url message:(NSString *)message excludedServices:(NSArray *)excludedServices {
    NSArray *items = [self activityItemsWithURL:url message:message];
    NSArray *applicationActivities = [self applicationActivitiesWithURL:url message:message];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items
                                                                                         applicationActivities:applicationActivities];
    activityViewController.excludedActivityTypes = [self excludedActivityTypesWithURL:url message:message excludedServices:excludedServices];
    activityViewController.completionHandler = [self completionHandler];
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

- (NSArray *)excludedActivityTypesWithURL:(NSURL *)url message:(NSString *)message excludedServices:(NSArray *)excludedServices {
    NSArray *javaScriptExcludedTypes = [SDJSShareService activityTypesFromShareServices:excludedServices];
    NSArray *delegateExcludedTypes = nil;

    @strongify(self.delegate, strongDelegate);

    if ([strongDelegate respondsToSelector:@selector(shareBridgeAPIExcludedActivityTypesWithURL:message:)]) {
        delegateExcludedTypes = [strongDelegate shareBridgeAPIExcludedActivityTypesWithURL:url message:message];
    }
    
    if (javaScriptExcludedTypes && delegateExcludedTypes) {
        javaScriptExcludedTypes = [javaScriptExcludedTypes arrayByAddingObjectsFromArray:delegateExcludedTypes];
    }
    
    
    return javaScriptExcludedTypes;
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

#pragma mark - SDJSShareScriptDelegate

- (NSArray *)shareBridgeAPIActivityItemsWithURL:(NSURL *)url message:(NSString *)message {
    return @[message, url];
}

- (NSArray *)shareBridgeAPIApplicationActivitiesWithURL:(NSURL *)url message:(NSString *)message {
    return nil;
}

- (NSArray *)shareBridgeAPIExcludedActivityTypesWithURL:(NSURL *)url message:(NSString *)message {
    return nil;
}

- (UIActivityViewControllerCompletionHandler)shareBridgeAPICompletionHandler {
    return ^(NSString *activityTtpe, BOOL completed) {
        if (completed) {
            // invoke JS callback
            [self runCallbackWithSender:nil];
        }
    };
}

- (void)shareBridgeAPIPresentActivityViewController:(UIActivityViewController *)activityViewController {
    [self.webViewController presentViewController:activityViewController animated:YES completion:nil];
}

#pragma mark - External API

- (void)shareWithOptions:(NSDictionary *)options {
    NSString *message = options[SDJSShareScriptMessageKey];
    NSURL *url = [NSURL URLWithString:options[SDJSShareScriptURLKey]];
    [self shareURL:url message:message excludedServices:nil];
}

@end
