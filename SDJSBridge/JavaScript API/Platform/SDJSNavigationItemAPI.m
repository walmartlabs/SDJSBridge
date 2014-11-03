//
//  SDJSNavigationItemAPI.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/3/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSNavigationItemAPI.h"

@interface SDJSNavigationItem : NSObject <JSExport>
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) SDJSNavigationItemCallback callback;
@end

@implementation SDJSNavigationItem
@end

@implementation SDJSNavigationItemAPI

- (SDJSNavigationItem *)navigationItemWithTitle:(NSString *)title
                                      imageName:(NSString *)imageName
                                       callback:(SDJSNavigationItemCallback)callback {
    SDJSNavigationItem *navigationItem = [SDJSNavigationItem new];
    navigationItem.title = title;
    navigationItem.imageName = imageName;
    navigationItem.callback = callback;
    return nil;
}

@end
