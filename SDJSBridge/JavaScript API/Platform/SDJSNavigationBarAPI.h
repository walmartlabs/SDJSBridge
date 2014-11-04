//
//  SDJSNavigationBarAPI.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/3/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol SDJSNavigationBarAPIExports <JSExport>

@property (nonatomic, readonly) NSArray *leftItems;
@property (nonatomic, readonly) NSArray *rightItems;

- (void)setLeftItems:(NSArray *)items;
- (void)setRightItems:(NSArray *)items;

@end

@interface SDJSNavigationBarAPI : SDJSBridgeScript <SDJSNavigationBarAPIExports>

@property (nonatomic, readonly) NSArray *leftItems;
@property (nonatomic, readonly) NSArray *rightItems;

- (void)setLeftItems:(NSArray *)items;
- (void)setRightItems:(NSArray *)items;

@end
