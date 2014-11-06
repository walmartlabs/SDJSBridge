//
//  SDJSProgressAPI.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/6/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"

#import <JavaScriptCore/JavaScriptCore.h>

@protocol SDJSProgressAPIDelegate <NSObject>

@required

- (void)showProgressHUDWithMessage:(NSString *)message;
- (void)hideProgressHUD;

@end

@protocol SDJSProgressAPIExports <JSExport>

@property (nonatomic, copy) NSString *message;

JSExportAs(show, - (void)showWithMessage:(NSString *)message);
- (void)hide;

@end

@interface SDJSProgressAPI : SDJSBridgeScript <SDJSProgressAPIExports>

@property (nonatomic, copy) NSString *message;
@property (nonatomic, weak) id<SDJSProgressAPIDelegate> delegate;

- (void)showWithMessage:(NSString *)message;
- (void)hide;

@end
