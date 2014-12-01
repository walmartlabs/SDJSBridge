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

@interface SDJSNavigationAPITests : XCTestCase <UINavigationControllerDelegate>

@property (nonatomic, strong) XCTestExpectation *pushExpectation;
@property (nonatomic, strong) XCTestExpectation *popExpectation;
@property (nonatomic, strong) JSValue *popResult;
@property (nonatomic, strong) SDWebViewController *testWebViewController;

@end

@implementation SDJSNavigationAPITests

#pragma mark - Push

- (void)testPushURL {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UINavigationController *navController = (UINavigationController *)window.rootViewController;
    navController.delegate = self;
    SDWebViewController *webViewController = (SDWebViewController *)navController.topViewController;
    
    NSString *testJavascript = @"JSBridgeAPI.platform().navigation().pushUrl('example2.html', 'Page Title');";
    [webViewController evaluateScript:testJavascript];
    
    self.pushExpectation = [self expectationWithDescription:@"push open"];
    [self waitForExpectationsWithTimeout:2.0 handler:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)validatePushTestWithNavigationController:(UINavigationController *)navigationController {
    XCTAssertTrue(navigationController.viewControllers.count == 2);
    
    NSURL *pageTwoURL = [[NSBundle mainBundle] URLForResource:@"example2" withExtension:@"html"];
    SDWebViewController *webViewController = (SDWebViewController *)navigationController.topViewController;
    XCTAssertTrue([webViewController.url isEqual:pageTwoURL]);
    [self.pushExpectation fulfill];
}

#pragma mark - Pop

- (void)testPopURL {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UINavigationController *navController = (UINavigationController *)window.rootViewController;
    navController.delegate = self;
    SDWebViewController *webViewController = (SDWebViewController *)navController.topViewController;
    self.testWebViewController = [[SDWebViewController alloc] initWithWebView:webViewController.webView];
    
    NSURL *pageTwoURL = [[NSBundle mainBundle] URLForResource:@"example2" withExtension:@"html"];
    [self.testWebViewController loadURL:pageTwoURL];
    
    navController.viewControllers = @[webViewController, self.testWebViewController];
    
    self.popExpectation = [self expectationWithDescription:@"push open"];
    [self waitForExpectationsWithTimeout:2.0 handler:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)validatePopTestWithNavigationController:(UINavigationController *)navigationController {
    if (!self.popResult) {
        NSString *testJavascript = @"JSBridgeAPI.platform().navigation().popUrl();";
        self.popResult = [self.testWebViewController evaluateScript:testJavascript];
    } else {
        XCTAssertTrue(navigationController.viewControllers.count == 1);
        
        NSURL *pageOneURL = [[NSBundle mainBundle] URLForResource:@"example1" withExtension:@"html"];
        SDWebViewController *webViewController = (SDWebViewController *)navigationController.topViewController;
        XCTAssertTrue([webViewController.url isEqual:pageOneURL]);
        [self.popExpectation fulfill];
    }
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.pushExpectation) {
        [self validatePushTestWithNavigationController:navigationController];
    } else if (self.popExpectation) {
        [self validatePopTestWithNavigationController:navigationController];
    }
}

@end
