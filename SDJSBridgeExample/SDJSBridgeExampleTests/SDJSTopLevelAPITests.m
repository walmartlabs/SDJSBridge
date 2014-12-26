//
//  SDJSTopLevelAPITests.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/8/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSTopLevelAPI.h"
#import "SDWebViewController.h"
#import "SDJSBridge.h"
#import "XCTestCase+ExampleAppUtilities.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface SDJSTopLevelAPITests : XCTestCase

@end

@implementation SDJSTopLevelAPITests

#pragma mark - Tests

- (void)testInitialization {
    SDWebViewController *webViewController = [[SDWebViewController alloc] initWithURL:[self pageOneURL]];
    SDJSTopLevelAPI *api = [[SDJSTopLevelAPI alloc] initWithWebViewController:webViewController];
    
    XCTAssertTrue([api isKindOfClass:[SDJSTopLevelAPI class]]);
    XCTAssertTrue([webViewController isEqual:api.webViewController]);
}

//- (void)testJavaScriptExports {
//    SDJSBridge *bridge = [[SDJSBridge alloc] init];
//    SDJSTopLevelAPI *api = [[SDJSTopLevelAPI alloc] initWithWebViewController:nil];
//    [bridge addScriptObject:api name:SDJSTopLevelAPIScriptName];
//    SDJSPlatformAPI *platform = [[bridge evaluateScript:@"JSBridgeAPI.platform();"] toObject];
//    
//    XCTAssertTrue([platform isKindOfClass:[SDJSPlatformAPI class]]);
//}

@end
