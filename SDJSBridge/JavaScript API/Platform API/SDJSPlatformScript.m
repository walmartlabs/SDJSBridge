//
//  SDJSPlatformScript.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/5/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import "SDJSPlatformScript.h"
#import "SDJSBridgeInfo.h"
#import "SDJSBridgeScript+HandlerHelpers.h"

NSString * const SDJSPlatformScriptName = @"WebViewJavascriptBridge";
static NSUInteger const kSDJSPlatformScriptVersionNumber = 1;

@interface SDJSPlatformScript ()

@property (nonatomic, strong) SDJSAlertScript *alertScript;
@property (nonatomic, strong) SDJSNavigationScript *navigationScript;
@property (nonatomic, strong) SDJSWebDialogScript *webDialogScript;

@end

@implementation SDJSPlatformScript

#pragma mark - Web View Controller

- (void)setWebViewController:(SDWebViewController *)webViewController {
    [super setWebViewController:webViewController];
    _alertScript.webViewController = webViewController;
}

#pragma mark - Logging API

- (void)logValue:(JSValue *)value {
    NSLog(@"SDJSPlatformAPI: %@", value);
}

#pragma mark - SDJSBridgeScriptVersionExports

- (SDJSBridgeInfo *)info {
    return [SDJSBridgeInfo bridgeInfoWithAPILevel:kSDJSPlatformScriptVersionNumber];
}

#pragma mark - Alert

- (SDJSAlertScript *)alertScript {
    if (!_alertScript) {
        _alertScript = [[SDJSAlertScript alloc] initWithWebViewController:self.webViewController];
    }
    
    return _alertScript;
}

- (void)showAlertWithOptions:(NSDictionary *)options callback:(JSValue *)callback {
    [self.alertScript showAlertWithOptions:options callback:[SDJSPlatformScript handlerOutputBlockWithCallback:callback]];
}

#pragma mark - Navigation

- (SDJSNavigationScript *)navigationScript {
    if (!_navigationScript) {
        _navigationScript = [[SDJSNavigationScript alloc] initWithWebViewController:self.webViewController];
    }
    
    return _navigationScript;
}

- (void)pushStateWithOptions:(NSDictionary *)options {
    [self.navigationScript pushStateWithOptions:options];
}

- (void)replaceStateWithOptions:(NSDictionary *)options {
    [self.navigationScript replaceStateWithOptions:options];
    
}

- (void)back {
    [self.navigationScript back];
}

#pragma mark - Loading Indicator

- (SDJSProgressHUDScript *)progressScript {
    if (!_progressScript) {
        _progressScript = [[SDJSProgressHUDScript alloc] initWithWebViewController:self.webViewController];
    }
    
    return _progressScript;
}

- (void)showLoadingIndicatorWithOptions:(NSDictionary *)options {
    [self.progressScript showLoadingIndicatorWithOptions:options];
}

- (void)hideLoadingIndicator {
    [self.progressScript hide];
}

#pragma mark - Share

- (SDJSShareScript *)shareScript {
    if (!_shareScript) {
        _shareScript = [[SDJSShareScript alloc] initWithWebViewController:self.webViewController];
    }
    
    return _shareScript;
}

- (void)shareWithOptions:(NSDictionary *)options {
    [self.shareScript shareWithOptions:options];
}

#pragma mark - Web Dialog

- (SDJSWebDialogScript *)webDialogScript {
    if (!_webDialogScript) {
        _webDialogScript = [[SDJSWebDialogScript alloc] initWithWebViewController:self.webViewController];
    }
    
    return _webDialogScript;
}

- (void)showWebDialogWithOptions:(NSDictionary *)options callback:(JSValue *)callback {
    [self.webDialogScript showWebDialogWithOptions:options callback:[SDJSPlatformScript handlerOutputBlockWithCallback:callback]];
}

#pragma mark - Radio Dialog

- (SDJSRadioDialogScript *)radioDialogScript {
    if (!_radioDialogScript) {
        _radioDialogScript = [[SDJSRadioDialogScript alloc] initWithWebViewController:self.webViewController];
    }
    
    return _radioDialogScript;
}

- (void)showRadioDialogWithOptions:(NSDictionary *)options callback:(JSValue *)callback {
    
}

#pragma mark - Date Picker

- (SDJSDatePickerScript *)datePickerScript {
    if (!_datePickerScript) {
        _datePickerScript = [[SDJSDatePickerScript alloc] init];
    }
    
    return _datePickerScript;
}

- (void)presentDatePickerWithOptions:(NSDictionary *)options callback:(JSValue *)callback {
    [self.datePickerScript presentDatePickerWithOptions:options callback:[SDJSPlatformScript handlerOutputBlockWithCallback:callback]];
}

@end
