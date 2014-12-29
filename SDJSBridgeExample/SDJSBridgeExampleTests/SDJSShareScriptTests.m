//
//  SDJSShareScriptTests.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/5/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDWebViewController.h"
#import "XCTestCase+ExampleAppUtilities.h"
#import "SDJSShareScript.h"
#import "SDJSTopLevelAPI.h"

#import <XCTest/XCTest.h>

@interface SDJSShareScriptTests : XCTestCase <SDJSShareScriptDelegate>

@property (nonatomic, assign) BOOL isActivityItemsCalled;
@property (nonatomic, assign) BOOL isApplicationActivitiesCalled;
@property (nonatomic, assign) BOOL isExcludedActivityTypesCalled;
@property (nonatomic, assign) BOOL isCompletionHandlerCalled;
@property (nonatomic, assign) BOOL isPresentCalled;
@property (nonatomic, copy) NSURL *shareURL;
@property (nonatomic, copy) NSString *shareMessage;
@property (nonatomic, copy) id shareCompletionBlock;

@end

@implementation SDJSShareScriptTests

- (void)testShare {
    SDWebViewController *webViewController = [[SDWebViewController alloc] initWithURL:[self pageOneURL]];
    
    SDJSTopLevelAPI *api = [[SDJSTopLevelAPI alloc] initWithWebViewController:webViewController];
    [webViewController addScriptObject:api name:SDJSTopLevelAPIScriptName];
    api.shareScript = [[SDJSShareScript alloc] initWithWebViewController:webViewController];
    api.shareScript.delegate = self;
    
    NSString *shareURLString = @"http://www.walmart.com/";
    self.shareURL = [NSURL URLWithString:shareURLString];
    self.shareMessage = @"Check out this great deal!";
    
    NSString *format = @"JSBridgeAPI.share({url: '%@', message: '%@'});";
    NSString *script = [NSString stringWithFormat:format, shareURLString, self.shareMessage];

    [webViewController evaluateScript:script];

    XCTAssertTrue(self.isActivityItemsCalled);
    XCTAssertTrue(self.isApplicationActivitiesCalled);
    XCTAssertTrue(self.isExcludedActivityTypesCalled);
    XCTAssertTrue(self.isCompletionHandlerCalled);
    XCTAssertTrue(self.isPresentCalled);
}

#pragma mark - SDJSShareScriptDelegate

- (NSArray *)shareBridgeAPIActivityItemsWithURL:(NSURL *)url message:(NSString *)message {
    self.isActivityItemsCalled = YES;
    
    XCTAssertTrue([url isEqual:self.shareURL]);
    XCTAssertTrue([message isEqualToString:self.shareMessage]);
    
    return @[message, url];
}

- (NSArray *)shareBridgeAPIApplicationActivitiesWithURL:(NSURL *)url message:(NSString *)message {
    self.isApplicationActivitiesCalled = YES;

    XCTAssertTrue([url isEqual:self.shareURL]);
    XCTAssertTrue([message isEqualToString:self.shareMessage]);

    return nil;
}

- (NSArray *)shareBridgeAPIExcludedActivityTypesWithURL:(NSURL *)url message:(NSString *)message {
    self.isExcludedActivityTypesCalled = YES;

    XCTAssertTrue([url isEqual:self.shareURL]);
    XCTAssertTrue([message isEqualToString:self.shareMessage]);

    return nil;
}

- (UIActivityViewControllerCompletionHandler)shareBridgeAPICompletionHandler {
    self.shareCompletionBlock = ^{};
    self.isCompletionHandlerCalled = YES;
    return self.shareCompletionBlock;
}

- (void)shareBridgeAPIPresentActivityViewController:(UIActivityViewController *)activityViewController {
    self.isPresentCalled = YES;
    
    XCTAssertTrue([self.shareCompletionBlock isEqual:activityViewController.completionHandler]);
    XCTAssertTrue([activityViewController isKindOfClass:[UIActivityViewController class]]);
}

@end
