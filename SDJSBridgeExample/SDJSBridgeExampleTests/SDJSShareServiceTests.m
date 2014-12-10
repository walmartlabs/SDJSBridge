//
//  SDJSShareServiceTests.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/5/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//


#import "SDJSShareService.h"
#import <XCTest/XCTest.h>

@interface SDJSShareServiceTests : XCTestCase

@end

@implementation SDJSShareServiceTests

- (void)testShareServiceWrappers {
    XCTAssertTrue([SDJSShareService facebook].activityType == UIActivityTypePostToFacebook);
    XCTAssertTrue([SDJSShareService twitter].activityType == UIActivityTypePostToTwitter);
    XCTAssertTrue([SDJSShareService mail].activityType == UIActivityTypeMail);
    XCTAssertTrue([SDJSShareService message].activityType == UIActivityTypeMessage);
    XCTAssertTrue([SDJSShareService flickr].activityType == UIActivityTypePostToFlickr);
    XCTAssertTrue([SDJSShareService vimeo].activityType == UIActivityTypePostToVimeo);
}

- (void)testActivityTypeConversion {
    NSArray *services = @[[SDJSShareService facebook], [SDJSShareService mail]];
    NSArray *activityTypes = [SDJSShareService activityTypesFromShareServices:services];
    
    XCTAssertTrue([activityTypes isKindOfClass:[NSArray class]]);
    XCTAssertTrue(activityTypes.count == 2);
    XCTAssertTrue(activityTypes[0] == UIActivityTypePostToFacebook);
    XCTAssertTrue(activityTypes[1] == UIActivityTypeMail);
}

@end
