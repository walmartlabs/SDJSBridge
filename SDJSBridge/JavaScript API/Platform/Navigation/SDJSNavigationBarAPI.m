//
//  SDJSNavigationBarAPI.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/3/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSNavigationBarAPI.h"

#import "SDJSNavigationItem.h"
#import "SDWebViewController.h"

@interface SDJSNavigationBarAPI ()

@property (nonatomic, copy) NSArray *leftNavigationItems;
@property (nonatomic, copy) NSArray *rightNavigationItems;

@end

@implementation SDJSNavigationBarAPI

#pragma mark - Navigation Items

- (NSArray *)leftItems {
    return _leftNavigationItems;
}

- (void)setLeftItems:(NSArray *)items {
    self.leftNavigationItems = items;
    NSArray *barButtonItems = [self barButtonItemsWithNavigationItems:_leftNavigationItems];
    self.webViewController.navigationItem.leftBarButtonItems = barButtonItems;
}

- (NSArray *)rightItems {
    return _rightNavigationItems;
}

- (void)setRightItems:(NSArray *)items {
    self.rightNavigationItems = items;
    NSArray *barButtonItems = [self barButtonItemsWithNavigationItems:_rightNavigationItems];
    self.webViewController.navigationItem.rightBarButtonItems = barButtonItems;
}

#pragma mark - UIBarButton

- (NSArray *)barButtonItemsWithNavigationItems:(NSArray *)navigationItems {
    NSMutableArray *items = [NSMutableArray array];
    
    for (SDJSNavigationItem *navigationItem in navigationItems) {
        [items addObject:[navigationItem barButtonItem]];
    }
    
    return [items copy];
}

@end
