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

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) XCTestExpectation *pushExpectation;
@property (nonatomic, strong) XCTestExpectation *popExpectation;
@property (nonatomic, strong) XCTestExpectation *presentModalExpectation;
@property (nonatomic, assign) BOOL isPushFulfilled;
@property (nonatomic, assign) BOOL isPopFulfilled;
@property (nonatomic, assign) BOOL isPresentFulfilled;

@end

@implementation SDJSNavigationAPITests

#pragma mark - Utilities

- (NSURL *)pageOneURL {
    return [[NSBundle mainBundle] URLForResource:@"example1" withExtension:@"html"];
}

- (NSURL *)pageTwoURL {
    return [[NSBundle mainBundle] URLForResource:@"example2" withExtension:@"html"];
}

- (void)testNavigationMethods {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    self.navigationController = (UINavigationController *)window.rootViewController;
    self.navigationController.delegate = self;
    
    self.pushExpectation = [self expectationWithDescription:@"push"];
    self.popExpectation = [self expectationWithDescription:@"pop"];
    self.presentModalExpectation = [self expectationWithDescription:@"present"];
    
    [self runPushURL];
    
    [self waitForExpectationsWithTimeout:4.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

#pragma mark - Push

- (void)runPushURL {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UINavigationController *navController = (UINavigationController *)window.rootViewController;
    navController.delegate = self;
    SDWebViewController *webViewController = (SDWebViewController *)navController.topViewController;
    
    NSString *testJavascript = @"JSBridgeAPI.platform().navigation().pushUrl('example2.html', 'Page Title');";
    [webViewController evaluateScript:testJavascript];
}

- (void)validatePushTestWithNavigationController:(UINavigationController *)navigationController {
    SDWebViewController *webViewController = (SDWebViewController *)navigationController.topViewController;
    
    XCTAssertTrue([webViewController.url isEqual:[self pageTwoURL]]);
    XCTAssertTrue(navigationController.viewControllers.count == 2);
    
    [self.pushExpectation fulfill];
    self.isPushFulfilled = YES;
    [self runPopURL];
}

#pragma mark - Pop

- (void)runPopURL {
    SDWebViewController *webViewController = (SDWebViewController *)self.navigationController.topViewController;
    NSString *testJavascript = @"JSBridgeAPI.platform().navigation().popUrl();";
    [webViewController evaluateScript:testJavascript];
}

- (void)validatePopTestWithNavigationController:(UINavigationController *)navigationController {
    SDWebViewController *webViewController = (SDWebViewController *)navigationController.topViewController;

    XCTAssertTrue([webViewController.url isEqual:[self pageOneURL]]);
    XCTAssertTrue(navigationController.viewControllers.count == 1);

    [self.popExpectation fulfill];
    self.isPopFulfilled = YES;
    [self runPresentURL];
}

#pragma mark - Present Modal

- (void)runPresentURL {
    SDWebViewController *webViewController = (SDWebViewController *)self.navigationController.topViewController;
    NSString *testJavascript = @"JSBridgeAPI.platform().navigation().presentModalUrl('example2.html', 'Page Title');";
    JSValue *rtn = [webViewController evaluateScript:testJavascript];
    SDWebViewController *modalWebViewController = [rtn toObject];
    UINavigationController *modalNavController = modalWebViewController.navigationController;
    modalNavController.delegate = self;
}

- (void)validatePresentModalTestWithNavigationController:(UINavigationController *)navigationController {
    SDWebViewController *webViewController = (SDWebViewController *)navigationController.topViewController;
    
    XCTAssertTrue([webViewController.url isEqual:[self pageTwoURL]]);
    XCTAssertTrue(navigationController.viewControllers.count == 1);
    
    [self.presentModalExpectation fulfill];
    self.isPresentFulfilled = YES;
    NSLog(@"present fulfill");
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (!self.isPushFulfilled) {
        [self validatePushTestWithNavigationController:navigationController];
    } else if (!self.isPopFulfilled) {
        [self validatePopTestWithNavigationController:navigationController];
    } else if (!self.isPresentFulfilled) {
        [self validatePresentModalTestWithNavigationController:navigationController];
    }
}

@end
