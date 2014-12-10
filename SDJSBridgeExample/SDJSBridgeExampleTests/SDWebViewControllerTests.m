//
//  SDWebViewControllerTests.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/10/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDWebViewController.h"
#import "XCTestCase+ExampleAppUtilities.h"
#import "SDJSBridge.h"
#import "SDJSTestScriptObject.h"
#import "SDJSBridgeScript.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface SDJSTestBridgeScript : SDJSBridgeScript <JSExport>
@end

@implementation SDJSTestBridgeScript
@end

@interface SDWebViewControllerTests : XCTestCase

@end

@implementation SDWebViewControllerTests

#pragma mark - Initialization Tests

- (void)testInitWithURL {
    NSURL *url = [self pageOneURL];
    SDWebViewController *webViewController = [[SDWebViewController alloc] initWithURL:url];
    
    XCTAssertTrue([webViewController.url isEqual:url]);
    XCTAssertTrue([webViewController.webView isKindOfClass:[UIWebView class]]);
    XCTAssertTrue(webViewController.delegate == nil);
}

- (void)testInitWithWebView {
    UIWebView *webView = [[UIWebView alloc] init];
    SDWebViewController *webViewController = [[SDWebViewController alloc] initWithWebView:webView];
    
    XCTAssertTrue([webViewController.webView isEqual:webView]);
    XCTAssertTrue(webViewController.delegate == nil);
    XCTAssertTrue(webViewController.url == nil);
}

#pragma mark - Navigation Tests

- (void)testPushURL {
    NSURL *expectedURL = [self pageTwoURL];
    NSString *expectedTitle = @"Page Two";
    
    SDWebViewController *webViewController = [[SDWebViewController alloc] initWithURL:[self pageOneURL]];
    SDWebViewController *newWebViewController = [webViewController pushURL:expectedURL title:expectedTitle];
    [self validateNavTestsWithWebViewController:newWebViewController expectedURL:expectedURL expectedTitle:expectedTitle];
}

- (void)testPresentURL {
    NSURL *expectedURL = [self pageTwoURL];
    NSString *expectedTitle = @"Page Two";
    
    SDWebViewController *webViewController = [[SDWebViewController alloc] initWithURL:[self pageOneURL]];
    SDWebViewController *newWebViewController = [webViewController presentURL:expectedURL title:expectedTitle];
    [self validateNavTestsWithWebViewController:newWebViewController expectedURL:expectedURL expectedTitle:expectedTitle];
}

- (void)validateNavTestsWithWebViewController:(SDWebViewController *)webViewController
                                  expectedURL:(NSURL *)expectedURL
                                expectedTitle:(NSString *)expectedTitle {
    XCTAssertTrue([webViewController isKindOfClass:[SDWebViewController class]]);
    XCTAssertTrue([webViewController.url isEqual:expectedURL]);
    XCTAssertTrue([webViewController.title isEqualToString:expectedTitle]);
}

#pragma mark - Bridge Tests

- (void)testAddScriptObject {
    NSString *scriptName = @"TestScript";
    SDJSTestScriptObject *script = [[SDJSTestScriptObject alloc] init];
    
    SDWebViewController *webViewController = [[SDWebViewController alloc] initWithURL:[self pageOneURL]];
    [webViewController addScriptObject:script name:scriptName];
    SDJSTestScriptObject *resultScript = [[webViewController evaluateScript:scriptName] toObject];
    
    XCTAssertTrue([resultScript isKindOfClass:[SDJSTestScriptObject class]]);
}

- (void)testAddScriptMethod {
    SDWebViewController *webViewController = [[SDWebViewController alloc] initWithURL:[self pageOneURL]];
    
    NSString *methodName = @"testMethod";
    id testBlock = ^{};
    [webViewController addScriptMethod:methodName block:testBlock];
    id block = [[webViewController evaluateScript:methodName] toObject];
    
    XCTAssertTrue([block isEqual:testBlock]);
}

- (void)testConfigureScripts {
    SDWebViewController *webViewController = [[SDWebViewController alloc] initWithURL:[self pageOneURL]];
    SDJSTestBridgeScript *script = [[SDJSTestBridgeScript alloc] init];
    NSString *scriptName = @"TestScript";
    [webViewController addScriptObject:script name:scriptName];
    [webViewController configureScriptObjects];
    
    XCTAssertTrue([script.webViewController isEqual:webViewController]);
}

@end
