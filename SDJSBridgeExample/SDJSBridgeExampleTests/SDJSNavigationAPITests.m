//
//  SDJSNavigationAPITests.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/28/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDWebViewController.h"
#import "SDJSTopLevelAPI.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface SDJSNavigationAPITests : XCTestCase <UINavigationControllerDelegate, SDWebViewControllerDelegate>

@property (nonatomic, strong) XCTestExpectation *pushOpenedExpectation;
@end

@implementation SDJSNavigationAPITests

- (void)testPushURL {
    self.pushOpenedExpectation = [self expectationWithDescription:@"push open"];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UINavigationController *navController = (UINavigationController *)window.rootViewController;
    navController.delegate = self;
    SDWebViewController *webViewController = (SDWebViewController *)navController.topViewController;
    
    NSString *testJavascript = @"JSBridgeAPI.platform().navigation().pushUrl('example2.html', 'Page Title');";
    [webViewController evaluateScript:testJavascript];
    
    [self waitForExpectationsWithTimeout:2.0 handler:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.pushOpenedExpectation) {
        XCTAssertTrue(navigationController.viewControllers.count == 2);
        
        NSURL *pageTwoURL = [[NSBundle mainBundle] URLForResource:@"example2" withExtension:@"html"];
        SDWebViewController *webViewController = (SDWebViewController *)navigationController.topViewController;
        XCTAssertTrue([webViewController.url isEqual:pageTwoURL]);
        
        [self.pushOpenedExpectation fulfill];
    }
}

@end
