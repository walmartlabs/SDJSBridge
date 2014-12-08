//
//  SDJSShareAPITests.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/5/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDWebViewController.h"
#import "XCTestCase+ExampleAppUtilities.h"

#import <XCTest/XCTest.h>

@interface SDJSShareAPITests : XCTestCase

@end

@implementation SDJSShareAPITests

- (void)testBasicShare {
    SDWebViewController *webViewController = [self rootWebViewController];
    NSString *urlString = @"http://www.walmart.com/";
    NSString *message = @"Check out this great deal!";
    NSString *format = @"JSBridgeAPI.platform().share('%@', '%@');";
    NSString *script = [NSString stringWithFormat:format, urlString, message];
    
    JSValue *rtn = [webViewController evaluateScript:script];
    UIActivityViewController *activityViewController = [rtn toObject];
    
    XCTAssertTrue([activityViewController isKindOfClass:[UIActivityViewController class]]);
    XCTAssertTrue(activityViewController.presentingViewController != nil);
}

@end
