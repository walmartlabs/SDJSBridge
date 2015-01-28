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

@interface SDWebViewControllerTests : XCTestCase <SDWebViewControllerDelegate>

@property (nonatomic, strong) SDWebViewController *expectedWebViewController;
@property (nonatomic, strong) XCTestExpectation *didStartLoadExpectation;
@property (nonatomic, strong) XCTestExpectation *didFinishLoadExpectation;
@property (nonatomic, strong) XCTestExpectation *didCreateJavaScriptContextExpectation;
@property (nonatomic, strong) XCTestExpectation *shouldOpenRequestExpectation;
@property (nonatomic, strong) XCTestExpectation *configureScriptObjectsExpectation;

@property (nonatomic, assign) BOOL isDidCreateJavaScriptContextFulfilled;
@property (nonatomic, assign) BOOL isLoadFulfilled;
@property (nonatomic, assign) BOOL isConfigureScriptObjectsFulfilled;

@end

@implementation SDWebViewControllerTests

#pragma mark - Initialization Tests

- (void)testInitWithURL {
    NSURL *url = [self pageOneURL];
    SDWebViewController *webViewController = [[SDWebViewController alloc] initWithURL:url];
    
    XCTAssertTrue([webViewController.url isEqual:url]);
    XCTAssertTrue([webViewController.webView isKindOfClass:[UIWebView class]]);
    XCTAssertTrue(webViewController.delegate == nil);
    XCTAssertTrue([webViewController shouldHandleURL:nil]);
}

- (void)testInitWithWebView {
    UIWebView *webView = [[UIWebView alloc] init];
    SDWebViewController *webViewController = [[SDWebViewController alloc] initWithWebView:webView];
    
    XCTAssertTrue([webViewController.webView isEqual:webView]);
    XCTAssertTrue(webViewController.delegate == nil);
    XCTAssertTrue(webViewController.url == nil);
    XCTAssertTrue([webViewController shouldHandleURL:nil]);
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
    SDWebViewController *newWebViewController = [webViewController presentModalURL:expectedURL title:expectedTitle];
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

#pragma mark - Delegate Tests

- (void)loadWebViewControllerAndWaitForExpectations {
    self.expectedWebViewController = [[SDWebViewController alloc] init];
    self.expectedWebViewController.delegate = self;
    [self.expectedWebViewController loadURL:[self pageOneURL]];
    
    [self waitForExpectationsWithTimeout:3.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

- (void)testShouldOpenRequestDelegateMethod {
    self.didStartLoadExpectation = [self expectationWithDescription:@"did start load"];
    self.didFinishLoadExpectation = [self expectationWithDescription:@"did finish load"];
    self.didCreateJavaScriptContextExpectation = [self expectationWithDescription:@"did create javaccript context"];
    self.shouldOpenRequestExpectation = [self expectationWithDescription:@"should open request"];
    self.configureScriptObjectsExpectation = [self expectationWithDescription:@"configure script objects"];

    self.expectedWebViewController = [[SDWebViewController alloc] init];
    self.expectedWebViewController.delegate = self;
    [self.expectedWebViewController loadURL:[self pageOneURL]];
    [self.expectedWebViewController configureScriptObjects];
    
    [self waitForExpectationsWithTimeout:2.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

- (void)runShouldOpenRequestTest {
    // invoke href click via JS to test shouldOpenRequest:
    NSString *clickScript = @"document.getElementById('test-href').click();";
    [self.expectedWebViewController evaluateScript:clickScript];
}

#pragma mark - SDWebViewControllerDelegate

- (void)webViewControllerDidStartLoad:(SDWebViewController *)controller {
    XCTAssertTrue([self.expectedWebViewController isEqual:controller]);

    if (!self.isLoadFulfilled) {
        [self.didStartLoadExpectation fulfill];
    }
}

- (void)webViewControllerDidFinishLoad:(SDWebViewController *)controller {
    XCTAssertTrue([self.expectedWebViewController isEqual:controller]);
    
    if (!self.isLoadFulfilled) {
        [self.didFinishLoadExpectation fulfill];
        self.isLoadFulfilled = YES;
        [self runShouldOpenRequestTest];
    }
}

- (BOOL)webViewController:(SDWebViewController *)controller shouldOpenRequest:(NSURLRequest *)request {
    XCTAssertTrue([self.expectedWebViewController isEqual:controller]);
    [self.shouldOpenRequestExpectation fulfill];
    return YES;
}

- (void)webViewController:(SDWebViewController *)controller didCreateJavaScriptContext:(JSContext *)context {
    XCTAssertTrue([self.expectedWebViewController isEqual:controller]);
    
    if (!self.isDidCreateJavaScriptContextFulfilled) {
        [self.didCreateJavaScriptContextExpectation fulfill];
        self.isDidCreateJavaScriptContextFulfilled = YES;
    }
}

- (void)webViewControllerConfigureScriptObjects:(SDWebViewController *)controller {
    XCTAssertTrue([self.expectedWebViewController isEqual:controller]);
    
    if (!self.isConfigureScriptObjectsFulfilled) {
        [self.configureScriptObjectsExpectation fulfill];
        self.isConfigureScriptObjectsFulfilled = YES;
    }
}

@end
