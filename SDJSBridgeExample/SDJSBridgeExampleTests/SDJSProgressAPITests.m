//
//  SDJSProgressAPITests.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/8/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDWebViewController.h"
#import "XCTestCase+ExampleAppUtilities.h"
#import "SDJSPlatformAPI.h"
#import "SDJSTopLevelAPI.h"
#import "SDJSProgressAPI.h"
#import "SDJSBridge.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface SDJSProgressAPITests : XCTestCase <SDJSProgressAPIDelegate>

@property (nonatomic, copy) NSString *progressMessage;
@property (nonatomic, assign) BOOL isShowCalled;
@property (nonatomic, assign) BOOL isHideCalled;

@end

@implementation SDJSProgressAPITests

#pragma mark - Tests

- (void)testJavaScriptExports {
    SDJSBridge *bridge = [[SDJSBridge alloc] init];
    SDJSProgressAPI *progressAPI = [[SDJSProgressAPI alloc] initWithWebViewController:nil];
    [bridge addScriptObject:progressAPI name:@"progress"];
    
    NSDictionary *showMember = [[bridge evaluateScript:@"progress.show;"] toObject];
    NSDictionary *hideMember = [[bridge evaluateScript:@"progress.hide;"] toObject];

    XCTAssertTrue([showMember isKindOfClass:[NSDictionary class]]);
    XCTAssertTrue([hideMember isKindOfClass:[NSDictionary class]]);
}

- (void)testShowProgress {
    SDJSBridge *bridge = [[SDJSBridge alloc] init];
    SDJSTopLevelAPI *api = [[SDJSTopLevelAPI alloc] initWithWebViewController:nil];
    [bridge addScriptObject:api name:SDJSTopLevelAPIScriptName];
    api.platform.progressScript.delegate = self;
    
    NSString *originalMessage = @"One moment please...";
    NSString *format = @"JSBridgeAPI.platform().progress().show('%@');";
    NSString *script = [NSString stringWithFormat:format, originalMessage];
    [bridge evaluateScript:script];
    
    XCTAssertTrue(self.isShowCalled);
    XCTAssertTrue([self.progressMessage isEqualToString:originalMessage]);
}

- (void)testHideProgress {
    SDJSBridge *bridge = [[SDJSBridge alloc] init];
    SDJSTopLevelAPI *api = [[SDJSTopLevelAPI alloc] initWithWebViewController:nil];
    [bridge addScriptObject:api name:SDJSTopLevelAPIScriptName];
    api.platform.progressScript.delegate = self;
    
    NSString *script = @"JSBridgeAPI.platform().progress().hide();";
    [bridge evaluateScript:script];
    
    XCTAssertTrue(self.isHideCalled);
}

#pragma mark - SDJSProgressAPIDelegate

- (void)showProgressHUDWithMessage:(NSString *)message {
    self.isShowCalled = YES;
    self.progressMessage = message;
}

- (void)hideProgressHUD {
    self.isHideCalled = YES;
}

@end
