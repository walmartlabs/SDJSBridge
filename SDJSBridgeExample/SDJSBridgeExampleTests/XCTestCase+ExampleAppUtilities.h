//
//  XCTestCase+ExampleAppUtilities.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/3/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>

@class SDWebViewController;

@interface XCTestCase (ExampleAppUtilities)

- (NSURL *)pageOneURL;
- (NSURL *)pageTwoURL;
- (UINavigationController *)windowNavigationController;
- (SDWebViewController *)rootWebViewController;

@end
