//
//  SDJSNavigationItem.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/3/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeResponder.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol SDJSNavigationItemExports <JSExport>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;

@end

@interface SDJSNavigationItem : SDJSBridgeResponder <SDJSNavigationItemExports>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;

+ (instancetype)navigationItemWithTitle:(NSString *)title imageName:(NSString *)imageName callback:(JSValue *)callback;
- (UIBarButtonItem *)barButtonItem;

@end
