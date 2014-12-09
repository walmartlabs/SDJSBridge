//
//  SDJSBridgeResponderTests.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/9/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeResponder.h"
#import "SDJSBridge.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface SDJSBridgeResponderTests : XCTestCase

@end

@implementation SDJSBridgeResponderTests

#pragma mark - Tests

- (void)testInitialization {
    NSString *methodName = @"_responderCallback";
    SDJSBridge *bridge = [[SDJSBridge alloc] init];
    [bridge addScriptMethod:methodName block:^{}];
    
    JSValue *callback = [bridge scriptValueForName:methodName];
    SDJSBridgeResponder *responder = [[SDJSBridgeResponder alloc] initWithCallback:callback];
    
    XCTAssertTrue([responder isKindOfClass:[SDJSBridgeResponder class]]);
    XCTAssertTrue([responder.callback isEqualToObject:callback]);
}

- (void)testExports {
    NSString *scriptName = @"responderTest";
    NSString *methodName = @"_responderCallback";
    SDJSBridge *bridge = [[SDJSBridge alloc] init];
    [bridge addScriptMethod:methodName block:^{}];
    
    JSValue *callback = [bridge scriptValueForName:methodName];
    SDJSBridgeResponder *responder = [[SDJSBridgeResponder alloc] initWithCallback:callback];
    [bridge addScriptObject:responder name:scriptName];
    
    SDJSBridgeResponder *responderBridgedValue = [[bridge scriptValueForName:scriptName] toObject];
    JSValue *callbackBridgedValue = [bridge evaluateScript:[NSString stringWithFormat:@"%@.callback", scriptName]];
    
    XCTAssertTrue([responderBridgedValue isKindOfClass:[SDJSBridgeResponder class]]);
    XCTAssertTrue([responder.callback isEqualToObject:callbackBridgedValue]);
}

- (void)testRunCallback {
    NSString *methodName = @"_responderCallback";
    SDJSBridge *bridge = [[SDJSBridge alloc] init];
    __block BOOL callbackFulfilled;
    
    [bridge addScriptMethod:methodName block:^{
        callbackFulfilled = YES;
    }];
    
    JSValue *callback = [bridge scriptValueForName:methodName];
    SDJSBridgeResponder *responder = [[SDJSBridgeResponder alloc] initWithCallback:callback];
    [bridge addScriptObject:responder name:@"responderTest"];
    [responder runCallbackWithSender:nil];
    
    XCTAssertTrue([responder.callback isEqualToObject:callback]);
    XCTAssertTrue(callbackFulfilled);
}

@end
