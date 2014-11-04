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

@implementation SDJSNavigationBarAPI

#pragma mark - Navigation Items

- (NSArray *)leftItems {
    return self.webViewController.navigationItem.leftBarButtonItems;
}

- (NSArray *)rightItems {
    return self.webViewController.navigationItem.rightBarButtonItems;
}

- (void)setLeftItems:(NSArray *)items {
    NSArray *barButtonItems = [self barButtonItemsWithNavigationItems:items];
    self.webViewController.navigationItem.leftBarButtonItems = barButtonItems;
}

- (void)setRightItems:(NSArray *)items {
    NSArray *barButtonItems = [self barButtonItemsWithNavigationItems:items];
    self.webViewController.navigationItem.rightBarButtonItems = barButtonItems;
}

#pragma mark - UIBarButton

- (NSArray *)barButtonItemsWithNavigationItems:(NSArray *)navigationItems {
    NSMutableArray *items = [NSMutableArray array];
    
    for (SDJSNavigationItem *navigationItem in navigationItems) {
        UIBarButtonItem *barButtonItem = [self barButtonItemWithNavigationItem:navigationItem];
        [items addObject:barButtonItem];
    }
    
    return [items copy];
}

- (UIBarButtonItem *)barButtonItemWithNavigationItem:(SDJSNavigationItem *)navigationItem {
    if (navigationItem.title) {
        return [[UIBarButtonItem alloc] initWithTitle:navigationItem.title
                                                style:UIBarButtonItemStylePlain
                                               target:navigationItem
                                               action:@selector(itemTapped:)];
    } else if (navigationItem.imageName) {
        return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:navigationItem.imageName]
                                                style:UIBarButtonItemStylePlain
                                               target:navigationItem
                                               action:@selector(itemTapped:)];
    }
    
    return nil;
}

@end
