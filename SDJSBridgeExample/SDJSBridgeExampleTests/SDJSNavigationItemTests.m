//
//  SDJSNavigationItemTests.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/3/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSNavigationItem.h"
#import "SDJSBridge.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface SDJSNavigationItemTests : XCTestCase

@end

@implementation SDJSNavigationItemTests

- (void)testNavigationItemWithTitle {
    NSString *callbackName = @"_navigationItemCallback";
    NSString *title = @"Test";
    
    SDJSBridge *bridge = [[SDJSBridge alloc] init];
    id callbackBlock = ^{};
    [bridge addScriptMethod:callbackName block:callbackBlock];
    
    JSValue *callback = [bridge scriptValueForName:callbackName];
    SDJSNavigationItem *navigationItem = [SDJSNavigationItem navigationItemWithTitle:title imageName:nil callback:callback];
    
    XCTAssertTrue([navigationItem isKindOfClass:[SDJSNavigationItem class]]);
    XCTAssertTrue([navigationItem.title isEqualToString:title]);
    XCTAssertTrue([navigationItem.callback isEqualToObject:callback]);
    XCTAssertTrue([navigationItem.callback toObject] != nil);
}

- (void)testBarButtonItem {
    NSString *title = @"Test";

    SDJSNavigationItem *navigationItem = [SDJSNavigationItem navigationItemWithTitle:title imageName:nil callback:nil];
    UIBarButtonItem *barButtonItem = [navigationItem barButtonItem];
    
    XCTAssertTrue([barButtonItem isKindOfClass:[UIBarButtonItem class]]);
    XCTAssertTrue([barButtonItem.title isEqualToString:title]);
    XCTAssertTrue([barButtonItem.target isEqual:navigationItem]);
}

@end
