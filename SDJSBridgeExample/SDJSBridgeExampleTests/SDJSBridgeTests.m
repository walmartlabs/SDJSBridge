//
//  SDJSBridgeTests.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/9/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridge.h"
#import "SDJSTestScriptObject.h"

@import JavaScriptCore;
@import XCTest;

@interface SDJSBridgeTests : XCTestCase

@end

@implementation SDJSBridgeTests

#pragma mark - Tests

- (void)testAddScriptMethod {
    SDJSBridge *bridge = [[SDJSBridge alloc] init];
    
    NSString *methodName = @"testMethod";
    id testBlock = ^{};
    [bridge addScriptMethod:methodName block:testBlock];
    id block = [[bridge evaluateScript:methodName] toObject];
    
    XCTAssertTrue([block isEqual:testBlock]);
}

- (void)testAddScriptObject {
    NSString *scriptName = @"TestScript";
    SDJSTestScriptObject *script = [[SDJSTestScriptObject alloc] init];

    SDJSBridge *bridge = [[SDJSBridge alloc] init];
    [bridge addScriptObject:script name:scriptName];
    SDJSTestScriptObject *resultScript = [[bridge evaluateScript:scriptName] toObject];
    
    XCTAssertTrue([resultScript isKindOfClass:[SDJSTestScriptObject class]]);
}

- (void)testConfigureContext {
    NSString *scriptName = @"TestScript";
    SDJSTestScriptObject *script = [[SDJSTestScriptObject alloc] init];
    SDJSBridge *bridge = [[SDJSBridge alloc] init];
    [bridge addScriptObject:script name:scriptName];
    
    JSContext *newContext = [[JSContext alloc] initWithVirtualMachine:[[JSVirtualMachine alloc] init]];
    [bridge configureContext:newContext];
    SDJSTestScriptObject *resultScript = [[bridge evaluateScript:scriptName] toObject];
    
    XCTAssertTrue([resultScript isKindOfClass:[SDJSTestScriptObject class]]);
}

- (void)testScriptObjects {
    NSString *scriptName = @"TestScript";
    SDJSTestScriptObject *script = [[SDJSTestScriptObject alloc] init];
    SDJSBridge *bridge = [[SDJSBridge alloc] init];
    [bridge addScriptObject:script name:scriptName];
    
    XCTAssertTrue(bridge.scriptObjects.count == 1);
    XCTAssertTrue([bridge.scriptObjects[scriptName] isEqual:script]);
}

@end
