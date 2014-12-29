//
//  SDJSProgressHUDScriptTests.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/8/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDWebViewController.h"
#import "SDJSTopLevelAPI.h"
#import "SDJSProgressHUDScript.h"
#import "SDJSBridge.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface SDJSProgressHUDScriptTests : XCTestCase <SDJSProgressHUDScriptDelegate>

@property (nonatomic, copy) NSString *progressMessage;
@property (nonatomic, assign) BOOL isShowCalled;
@property (nonatomic, assign) BOOL isHideCalled;

@end

@implementation SDJSProgressHUDScriptTests

#pragma mark - Tests

- (void)testShowProgress {
    SDJSBridge *bridge = [[SDJSBridge alloc] init];
    SDJSTopLevelAPI *api = [[SDJSTopLevelAPI alloc] initWithWebViewController:nil];
    [bridge addScriptObject:api name:@"bridge"];
    api.progressScript.delegate = self;
    
    NSString *originalMessage = @"One moment please...";
    NSString *format = @"bridge.showLoadingIndicator({message: '%@'});";
    NSString *script = [NSString stringWithFormat:format, originalMessage];
    [bridge evaluateScript:script];
    
    XCTAssertTrue(self.isShowCalled);
    XCTAssertTrue([self.progressMessage isEqualToString:originalMessage]);
}

- (void)testHideProgress {
    SDJSBridge *bridge = [[SDJSBridge alloc] init];
    SDJSTopLevelAPI *api = [[SDJSTopLevelAPI alloc] initWithWebViewController:nil];
    [bridge addScriptObject:api name:@"bridge"];
    api.progressScript.delegate = self;
    
    NSString *script = @"brige.hideLoadingIndicator();";
    [bridge evaluateScript:script];
    
    XCTAssertTrue(self.isHideCalled);
}

#pragma mark - SDJSProgressHUDScriptDelegate

- (void)showProgressHUDWithMessage:(NSString *)message {
    self.isShowCalled = YES;
    self.progressMessage = message;
}

- (void)hideProgressHUD {
    self.isHideCalled = YES;
}

@end
