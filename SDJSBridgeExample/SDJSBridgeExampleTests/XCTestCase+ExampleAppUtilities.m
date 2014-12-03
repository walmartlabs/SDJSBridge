//
//  XCTestCase+ExampleAppUtilities.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/3/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "XCTestCase+ExampleAppUtilities.h"
#import "SDWebViewController.h"

@implementation XCTestCase (ExampleAppUtilities)

- (NSURL *)pageOneURL {
    return [[NSBundle mainBundle] URLForResource:@"example1" withExtension:@"html"];
}

- (NSURL *)pageTwoURL {
    return [[NSBundle mainBundle] URLForResource:@"example2" withExtension:@"html"];
}

- (UINavigationController *)windowNavigationController {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    return (UINavigationController *)window.rootViewController;
}

- (SDWebViewController *)rootWebViewController {
    return (SDWebViewController *)[self windowNavigationController].topViewController;
}

@end
