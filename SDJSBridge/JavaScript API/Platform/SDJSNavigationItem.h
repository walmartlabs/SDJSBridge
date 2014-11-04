//
//  SDJSNavigationItem.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/3/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol SDJSNavigationItemExports <JSExport>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, strong) JSValue *callback;

@end

@interface SDJSNavigationItem : NSObject <SDJSNavigationItemExports>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, strong) JSValue *callback;

- (void)itemTapped:(id)sender;

@end
