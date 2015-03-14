//
//  SDJSBridgeInfo.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/9/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol SDJSBridgeInfoExports <JSExport>

@property (nonatomic, copy, readonly) NSString *osName;
@property (nonatomic, copy, readonly) NSString *osVersion;
@property (nonatomic, copy, readonly) NSArray *latestAniviaEvents;
@property (nonatomic, assign, readonly) NSUInteger apiLevel;

@end

@interface SDJSBridgeInfo : NSObject <SDJSBridgeInfoExports>

@property (nonatomic, copy, readonly) NSString *osName;
@property (nonatomic, copy, readonly) NSString *osVersion;
@property (nonatomic, copy, readonly) NSArray *latestAniviaEvents;
@property (nonatomic, assign, readonly) NSUInteger apiLevel;

+ (instancetype)bridgeInfoWithAPILevel:(NSUInteger)apiLevel;

- (instancetype)initWithAPILevel:(NSUInteger)apiLevel;

/**
 This is to add data for the latestAniviaEvents key that goes out in info so we 
 can map Anivia to Beacon events.
 
 @param aniviaEvents - The events dictionary that need to go out with the bridge.
 */
- (void)updateWithAniviaEvents:(NSArray *)aniviaEvents;
@end
