//
//  SDJSNavigationItem.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/3/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSNavigationItem.h"

@implementation SDJSNavigationItem

+ (instancetype)navigationItemWithTitle:(NSString *)title imageName:(NSString *)imageName callback:(JSValue *)callback {
    SDJSNavigationItem *navigationItem = [[SDJSNavigationItem alloc] initWithCallback:callback];
    navigationItem.title = title;
    navigationItem.imageName = imageName;
    return navigationItem;
}

- (UIBarButtonItem *)barButtonItem {
    if (self.title) {
        return [[UIBarButtonItem alloc] initWithTitle:self.title
                                                style:UIBarButtonItemStylePlain
                                               target:self
                                               action:@selector(runCallbackWithSender:)];
    } else if (self.imageName) {
        return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:self.imageName]
                                                style:UIBarButtonItemStylePlain
                                               target:self
                                               action:@selector(runCallbackWithSender:)];
    }
    
    return nil;
}

@end
