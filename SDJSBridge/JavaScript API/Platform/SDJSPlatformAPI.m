//
//  SDJSPlatformAPI.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 10/30/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSPlatformAPI.h"

#import "SDJSNavigationAPI.h"
#import "SDJSProgressAPI.h"
#import "SDJSShareAPI.h"
#import "SDJSShareService.h"

@interface SDJSPlatformAPI ()

@property (nonatomic, copy) NSArray *actions;

@end

@implementation SDJSPlatformAPI

#pragma mark - Accessors

- (void)setWebViewController:(SDWebViewController *)webViewController {
    [super setWebViewController:webViewController];
    _navigationScript.webViewController = webViewController;
    _progressScript.webViewController = webViewController;
}

#pragma mark - Initialization

- (instancetype)initWithWebViewController:(SDWebViewController *)webViewController {
    if ((self = [super initWithWebViewController:webViewController])) {
        _navigationScript = [[SDJSNavigationAPI alloc] initWithWebViewController:webViewController];
        _progressScript = [[SDJSProgressAPI alloc] initWithWebViewController:webViewController];
    }
    
    return self;
}

#pragma mark - SDJSPlatformAPIExports

- (SDJSNavigationAPI *)navigation {
    return _navigationScript;
}

- (SDJSProgressAPI *)progress {
    return _progressScript;
}

- (NSDictionary *)ShareService {
    return [SDJSShareService allServices];
}

#pragma mark - Sharing

- (UIActivityViewController *)shareURL:(NSString *)urlString message:(NSString *)message callback:(JSValue *)callback {
    return [self shareURL:urlString message:message excludedServices:nil callback:callback];
}

- (UIActivityViewController *)shareURL:(NSString *)urlString message:(NSString *)message excludedServices:(NSArray *)excludedServices callback:(JSValue *)callback {
    if (!self.shareScript) {
        self.shareScript = [[SDJSShareAPI alloc] initWithWebViewController:self.webViewController];
    }
    
    self.shareScript.callback = callback;
    return [self.shareScript shareWithURL:[NSURL URLWithString:urlString] message:message excludedServices:excludedServices];
}

@end
