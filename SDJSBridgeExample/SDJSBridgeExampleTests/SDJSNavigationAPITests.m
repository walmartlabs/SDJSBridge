//
//  SDJSNavigationAPITests.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/28/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "XCTestCase+ExampleAppUtilities.h"
#import "SDWebViewController.h"
#import "SDJSTopLevelAPI.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface SDJSNavigationAPITests : XCTestCase <UINavigationControllerDelegate>

@property (nonatomic, strong) UINavigationController *activeNavigationController;
@property (nonatomic, strong) XCTestExpectation *pushExpectation;
@property (nonatomic, strong) XCTestExpectation *popExpectation;
@property (nonatomic, strong) XCTestExpectation *presentModalExpectation;
@property (nonatomic, strong) XCTestExpectation *dismissModalExpectation;
@property (nonatomic, assign) BOOL isPushFulfilled;
@property (nonatomic, assign) BOOL isPopFulfilled;
@property (nonatomic, assign) BOOL isPresentFulfilled;

@end

@implementation SDJSNavigationAPITests

#pragma mark - Accessors

- (void)setActiveNavigationController:(UINavigationController *)activeNavigationController {
    _activeNavigationController = activeNavigationController;
    _activeNavigationController.delegate = self;
}

#pragma mark - Tests

- (void)testPushPopPresentDismissFlow {
    self.pushExpectation = [self expectationWithDescription:@"push"];
    self.popExpectation = [self expectationWithDescription:@"pop"];
    self.presentModalExpectation = [self expectationWithDescription:@"present"];
    self.dismissModalExpectation = [self expectationWithDescription:@"dismiss"];

    [self runPushURL];
    
    [self waitForExpectationsWithTimeout:4.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

#pragma mark - Push

- (void)runPushURL {
    self.activeNavigationController = [self windowNavigationController];
    SDWebViewController *webViewController = [self rootWebViewController];
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
    SDWebViewController *webViewController = (SDWebViewController *)[self.activeNavigationController.viewControllers lastObject];
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
    SDWebViewController *webViewController = [self rootWebViewController];
    NSString *testJavascript = @"JSBridgeAPI.platform().navigation().presentModalUrl('example2.html', 'Page Title');";
    JSValue *rtn = [webViewController evaluateScript:testJavascript];
    SDWebViewController *modalWebViewController = [rtn toObject];
    self.activeNavigationController = modalWebViewController.navigationController;
}

- (void)validatePresentModalTestWithNavigationController:(UINavigationController *)navigationController {
    SDWebViewController *webViewController = (SDWebViewController *)navigationController.topViewController;
    SDWebViewController *presentingWebViewController = (SDWebViewController *)[self windowNavigationController].topViewController;

    XCTAssertTrue([webViewController.url isEqual:[self pageTwoURL]]);
    XCTAssertTrue(presentingWebViewController.presentedViewController !=nil);
    
    [self.presentModalExpectation fulfill];
    self.isPresentFulfilled = YES;
    [self runDismissURL];
}

#pragma mark - Dismiss Modal

- (void)runDismissURL {
    SDWebViewController *webViewController = (SDWebViewController *)self.activeNavigationController.topViewController;
    NSString *dismissCallbackName = @"_dismissURLCallback";
    
    // add JS callback for dismiss completion
    [webViewController addScriptMethod:dismissCallbackName block:^{
        [self validateDismissModalTest];
    }];
    
    NSString *testJavascript = [NSString stringWithFormat:@"JSBridgeAPI.platform().navigation().dismissModalUrl(%@);", dismissCallbackName];
    [webViewController evaluateScript:testJavascript];
}

- (void)validateDismissModalTest {
    UINavigationController *navigationController = [self windowNavigationController];
    SDWebViewController *webViewController = (SDWebViewController *)navigationController.topViewController;
    
    XCTAssertTrue([webViewController.url isEqual:[self pageOneURL]]);
    XCTAssertTrue(webViewController.presentedViewController == nil);
    
    [self.dismissModalExpectation fulfill];
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
