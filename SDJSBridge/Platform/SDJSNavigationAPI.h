//
//  SDJSNavigationAPI.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 10/30/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@class SDWebViewController;

@protocol SDJSNavigationAPIExports <JSExport>

JSExportAs(pushURL,
- (void)pushURL:(NSString *)urlString title:(NSString *)title
);

- (void)popURL;

JSExportAs(presentModalURL,
- (void)presentModalURL:(NSString *)urlString title:(NSString *)title
);

- (void)dismissModalURL;

@end

@interface SDJSNavigationAPI : NSObject <SDJSNavigationAPIExports>

- (instancetype)initWithWebViewController:(SDWebViewController *)webViewController;
- (void)pushURL:(NSString
                 *)urlString title:(NSString *)title;
- (void)popURL;
- (void)presentModalURL:(NSString *)urlString title:(NSString *)title;
- (void)dismissModalURL;

@end
