//
//  SDJSPlatformAPITests.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/4/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDWebViewController.h"
#import "XCTestCase+ExampleAppUtilities.h"
#import "SDJSAlertAction.h"
#import "SDJSPlatformAPI.h"
#import "SDJSBridge.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface SDJSPlatformAPITests : XCTestCase

@end

@implementation SDJSPlatformAPITests

#pragma mark - Alerts

- (void)testShowAlertActions {
    SDWebViewController *webViewController = [self rootWebViewController];
    NSString *yesCallbackName = @"_yesButtonTapped";
    NSString *cancelCallbackName = @"_cancelButtonTapped";
    NSString *scriptFormat = @" \
    var okAction = JSBridgeAPI.platform().AlertAction('Yes', %@); \
    var cancelAction = JSBridgeAPI.platform().AlertAction('Cancel', %@); \
    var actions = [cancelAction, okAction]; \
    JSBridgeAPI.platform().alert('Test Title', 'Test Message', actions);";
    NSString *script = [NSString stringWithFormat:scriptFormat, yesCallbackName, cancelCallbackName];

    XCTestExpectation *yesTappedExpectation = [self expectationWithDescription:@"yes tapped"];
    XCTestExpectation *cancelTappeddExpectation = [self expectationWithDescription:@"cancel tapped"];
    
    [webViewController addScriptMethod:yesCallbackName block:^{
        [yesTappedExpectation fulfill];
    }];
    
    [webViewController addScriptMethod:cancelCallbackName block:^{
        [cancelTappeddExpectation fulfill];
    }];
    
    JSValue *alertValue = [webViewController evaluateScript:script];
    UIAlertView *alert = [alertValue toObject];
    
    NSLog(@"%@", alert.delegate);

    XCTAssertTrue([alert isKindOfClass:[UIAlertView class]]);
    XCTAssertTrue(alert.isVisible);
    XCTAssertTrue(alert.numberOfButtons == 2);
    XCTAssertTrue([[alert buttonTitleAtIndex:0] isEqualToString:@"Cancel"]);
    XCTAssertTrue([[alert buttonTitleAtIndex:1] isEqualToString:@"Yes"]);
    XCTAssertTrue([alert.title isEqualToString:@"Test Title"]);
    XCTAssertTrue([alert.message isEqualToString:@"Test Message"]);
    
    [alert.delegate alertView:alert clickedButtonAtIndex:0];
    [alert.delegate alertView:alert clickedButtonAtIndex:1];
    [alert dismissWithClickedButtonIndex:0 animated:NO];
    
    [self waitForExpectationsWithTimeout:2.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

- (void)testCreateAlertAction {
    SDJSPlatformAPI *api = [[SDJSPlatformAPI alloc] initWithWebViewController:nil];
    
    SDJSBridge *bridge = [[SDJSBridge alloc] init];
    [bridge addScriptMethod:@"_callback" block:^{}];
    JSValue *callback = [bridge evaluateScript:@"_callback"];
    
    SDJSAlertAction *alertAction = [api alertActionWithTitle:@"Test Title" callback:callback];
    XCTAssertTrue([alertAction isKindOfClass:[SDJSAlertAction class]]);
    XCTAssertTrue([alertAction.title isEqualToString:@"Test Title"]);
}

@end
