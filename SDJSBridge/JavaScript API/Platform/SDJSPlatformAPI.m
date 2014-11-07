//
//  SDJSPlatformAPI.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 10/30/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSPlatformAPI.h"

#import "SDJSNavigationAPI.h"
#import "SDJSAlertAction.h"
#import "SDJSProgressAPI.h"

@interface SDJSPlatformAPI ()

@property (nonatomic, copy) NSArray *actions;

@end

@implementation SDJSPlatformAPI

- (instancetype)initWithWebViewController:(SDWebViewController *)webViewController {
    if ((self = [super initWithWebViewController:webViewController])) {
        _navigation = [[SDJSNavigationAPI alloc] initWithWebViewController:webViewController];
        _progress = [[SDJSProgressAPI alloc] initWithWebViewController:webViewController];
    }
    
    return self;
}

#pragma mark - Alerts

- (SDJSAlertAction *)alertActionWithTitle:(NSString *)title callback:(JSValue *)callback {
    return [SDJSAlertAction alertActionWithTitle:title callback:callback];
}

- (void)showAlert:(NSString *)title message:(NSString *)message actions:(NSArray *)actions {
    self.actions = actions;

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    
    for (SDJSAlertAction *action in self.actions) {
        [alert addButtonWithTitle:action.title];
    }
    
    if (!self.actions.count) {
        [alert addButtonWithTitle:@"OK"];
    }
    
    [alert show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    SDJSAlertAction *action = self.actions[(NSUInteger)buttonIndex];
    
    if (action) {
        [action performActionWithSender:alertView];
    }
}

@end
