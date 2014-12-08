//
//  SDJSTopLevelAPITests.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/8/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSTopLevelAPI.h"
#import "SDWebViewController.h"
#import "XCTestCase+ExampleAppUtilities.h"
#import "SDJSPlatformAPI.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface SDJSTopLevelAPITests : XCTestCase

@end

@implementation SDJSTopLevelAPITests

- (void)testInitialization {
    SDWebViewController *webViewController = [[SDWebViewController alloc] initWithURL:[self pageOneURL]];
    SDJSTopLevelAPI *api = [[SDJSTopLevelAPI alloc] initWithWebViewController:webViewController];
    
    XCTAssertTrue([api isKindOfClass:[SDJSTopLevelAPI class]]);
    XCTAssertTrue([api.platform isKindOfClass:[SDJSPlatformAPI class]]);
    XCTAssertTrue([webViewController isEqual:api.webViewController]);
}

- (void)testExports {
    SDWebViewController *webViewController = [[SDWebViewController alloc] initWithURL:[self pageOneURL]];
    SDJSTopLevelAPI *api = [[SDJSTopLevelAPI alloc] initWithWebViewController:webViewController];
    [webViewController addScriptObject:api name:SDJSTopLevelAPIScriptName];
    
    SDJSPlatformAPI *platform = [[webViewController evaluateScript:@"JSBridgeAPI.platform();"] toObject];
    
    XCTAssertTrue([platform isKindOfClass:[SDJSPlatformAPI class]]);
}

@end
