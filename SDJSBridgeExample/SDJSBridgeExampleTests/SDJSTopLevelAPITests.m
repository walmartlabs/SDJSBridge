//
//  SDJSPlatformScriptTests.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/8/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSPlatformScript.h"
#import "SDWebViewController.h"
#import "SDJSBridge.h"
#import "XCTestCase+ExampleAppUtilities.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface SDJSPlatformScriptTests : XCTestCase

@end

@implementation SDJSPlatformScriptTests

#pragma mark - Tests

- (void)testInitialization {
    SDWebViewController *webViewController = [[SDWebViewController alloc] initWithURL:[self pageOneURL]];
    SDJSPlatformScript *api = [[SDJSPlatformScript alloc] initWithWebViewController:webViewController];
    
    XCTAssertTrue([api isKindOfClass:[SDJSPlatformScript class]]);
    XCTAssertTrue([webViewController isEqual:api.webViewController]);
}

- (void)testJavaScriptExports {
    SDJSBridge *bridge = [[SDJSBridge alloc] init];
    SDJSPlatformScript *api = [[SDJSPlatformScript alloc] initWithWebViewController:nil];
    [bridge addScriptObject:api name:@"bridge"];
    NSDictionary *alertMember = [[bridge evaluateScript:@"bridge.alert"] toObject];
    NSDictionary *showLoadingIndicatorMember = [[bridge evaluateScript:@"bridge.showLoadingIndicator"] toObject];
    NSDictionary *hideLoadingIndicatorMember = [[bridge evaluateScript:@"bridge.hideLoadingIndicator"] toObject];
    NSDictionary *pushStateMember = [[bridge evaluateScript:@"bridge.pushState"] toObject];
    NSDictionary *replaceStateMember = [[bridge evaluateScript:@"bridge.replaceState"] toObject];

    XCTAssertTrue([alertMember isKindOfClass:[NSDictionary class]]);
    XCTAssertTrue([showLoadingIndicatorMember isKindOfClass:[NSDictionary class]]);
    XCTAssertTrue([hideLoadingIndicatorMember isKindOfClass:[NSDictionary class]]);
    XCTAssertTrue([pushStateMember isKindOfClass:[NSDictionary class]]);
    XCTAssertTrue([replaceStateMember isKindOfClass:[NSDictionary class]]);
}

@end
