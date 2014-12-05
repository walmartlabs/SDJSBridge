//
//  SDJSNavigationBarAPITests.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/2/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "XCTestCase+ExampleAppUtilities.h"
#import "SDWebViewController.h"
#import "SDJSNavigationItem.h"
#import "SDMacros.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

NS_ENUM(NSInteger, SDJSNavigationItemTestPlacement) {
    SDJSNavigationItemTestPlacementLeft = 0,
    SDJSNavigationItemTestPlacementRight = 1
};

@interface SDJSNavigationBarAPITests : XCTestCase

@end

@implementation SDJSNavigationBarAPITests

#pragma mark - JavaScript Tests

- (void)testSetLeftNavigationItem {
    [self runSetNavigationItemTestForPlacement:SDJSNavigationItemTestPlacementLeft];
}

- (void)testSetRightNavigationItem {
    [self runSetNavigationItemTestForPlacement:SDJSNavigationItemTestPlacementRight];
}

- (void)runSetNavigationItemTestForPlacement:(NSInteger)placement {
    XCTestExpectation *expectation = [self expectationWithDescription:@"setNavigationItems"];
    
    NSString *setMethodName = placement == SDJSNavigationItemTestPlacementLeft ? @"setLeftItems" : @"setRightItems";
    NSString *scriptFormat = @" \
    var navigation = JSBridgeAPI.platform().navigation(); \
    var navItem = navigation.NavigationItem('%@', null, %@); \
    navigation.navigationBar().%@([navItem]);";
    NSString *navigationItemTitle = @"OneTest";
    NSString *navigationItemCallback = @"_navigationItemCallback";
    NSString *script = [NSString stringWithFormat:scriptFormat, navigationItemTitle, navigationItemCallback, setMethodName];
    
    SDWebViewController *webViewController = [self rootWebViewController];

    @weakify(webViewController);
    // add JS function to test nav item callback
    [webViewController addScriptMethod:navigationItemCallback block:^{
        @strongify(webViewController);
        
        // reset items for next test
        if (placement == SDJSNavigationItemTestPlacementLeft) {
            webViewController.navigationItem.leftBarButtonItem = nil;
        } else {
            webViewController.navigationItem.rightBarButtonItem = nil;
        }
        
        [expectation fulfill];
    }];
    
    [webViewController evaluateScript:script];
    
    UIBarButtonItem *button = placement == SDJSNavigationItemTestPlacementLeft ? webViewController.navigationItem.leftBarButtonItem : webViewController.navigationItem.rightBarButtonItem;

    XCTAssertTrue([button isKindOfClass:[UIBarButtonItem class]]);
    XCTAssertTrue([button.title isEqualToString:navigationItemTitle]);
    
    [(SDJSNavigationItem *)button.target performActionWithSender:nil];
    
    [self waitForExpectationsWithTimeout:2.0f handler:^(NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

- (void)testRemoveNavigationItems {
    SDWebViewController *webViewController = [self rootWebViewController];
    UIBarButtonItem *firstButton = [[UIBarButtonItem alloc] initWithTitle:@"One" style:UIBarButtonItemStyleDone target:nil action:nil];
    UIBarButtonItem *secondButton = [[UIBarButtonItem alloc] initWithTitle:@"One" style:UIBarButtonItemStyleDone target:nil action:nil];
    webViewController.navigationItem.leftBarButtonItems = @[firstButton, secondButton];
    
    NSString *script = @"JSBridgeAPI.platform().navigation().navigationBar().setLeftItems(null);";
    [webViewController evaluateScript:script];
    
    XCTAssertTrue(webViewController.navigationItem.leftBarButtonItems.count == 0);
}

@end
