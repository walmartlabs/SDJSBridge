//
//  SDJSPlatformAPITests.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/4/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDWebViewController.h"
#import "XCTestCase+ExampleAppUtilities.h"
#import "SDJSPlatformAPI.h"
#import "SDJSBridge.h"
#import "SDJSNavigationAPI.h"
#import "SDJSProgressAPI.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface SDJSPlatformAPITests : XCTestCase

@end

@implementation SDJSPlatformAPITests

#pragma mark - Platform API Tests

- (void)testInitialization {
    SDWebViewController *webViewController = [[SDWebViewController alloc] initWithURL:[self pageOneURL]];
    SDJSPlatformAPI *platform = [[SDJSPlatformAPI alloc] initWithWebViewController:webViewController];

    XCTAssertTrue(platform.shareScript == nil);
    XCTAssertTrue([platform.navigationScript isKindOfClass:[SDJSNavigationAPI class]]);
    XCTAssertTrue([platform.progressScript isKindOfClass:[SDJSProgressAPI class]]);
    XCTAssertTrue([webViewController isEqual:platform.webViewController]);
}

- (void)testJavaScriptExports {
    SDJSBridge *bridge = [[SDJSBridge alloc] init];
    SDJSPlatformAPI *platformAPI = [[SDJSPlatformAPI alloc] initWithWebViewController:nil];
    [bridge addScriptObject:platformAPI name:@"platform"];
    
    SDJSProgressAPI *progressAPI = [[bridge evaluateScript:@"platform.progress();"] toObject];
    SDJSNavigationAPI *navigationAPI = [[bridge evaluateScript:@"platform.navigation();"] toObject];
    NSDictionary *shareMember = [[bridge evaluateScript:@"platform.share;"] toObject];
    NSDictionary *shareService = [[bridge evaluateScript:@"platform.ShareService;"] toObject];
    NSDictionary *alertMember = [[bridge evaluateScript:@"platform.alert;"] toObject];
    NSDictionary *alertAction = [[bridge evaluateScript:@"platform.AlertAction;"] toObject];

    XCTAssertTrue([progressAPI isKindOfClass:[SDJSProgressAPI class]]);
    XCTAssertTrue([navigationAPI isKindOfClass:[SDJSNavigationAPI class]]);
    XCTAssertTrue([shareMember isKindOfClass:[NSDictionary class]]);
    XCTAssertTrue([shareService isKindOfClass:[NSDictionary class]]);
    XCTAssertTrue([alertMember isKindOfClass:[NSDictionary class]]);
    XCTAssertTrue([alertAction isKindOfClass:[NSDictionary class]]);
}

@end
