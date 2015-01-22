//
//  SDJSNavigationScript.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 12/22/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSNavigationScript.h"
#import "SDJSHandlerScript.h"
#import "SDWebViewController.h"
#import "SDMacros.h"

NSString * const kSDJSNavigationScriptTitleKey = @"title";
NSString * const kSDJSNavigationScriptBackTitleKey = @"backTitle";
NSString * const kSDJSNavigationScriptURLKey = @"url";
NSString * const kSDJSNavigationScriptShareTextKey = @"shareText";
NSString * const kSDJSNavigationScriptShareTitleKey = @"shareTitle";

@interface SDJSNavigationScript ()

@property (nonatomic, copy) NSString *shareTitle;
@property (nonatomic, copy) NSString *shareText;

@end

@implementation SDJSNavigationScript

#pragma mark - URL Construction

- (NSURL *)URLWithURLString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    
    if (!url.scheme) {
        NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:urlString withExtension:nil];
        url = bundleURL;
    }
    
    return url;
}

#pragma mark - Navigation

- (id)pushURL:(NSString *)urlString title:(NSString *)title backTitle:(NSString *)backTitle {
    NSURL *url = [self URLWithURLString:urlString];
    return [self.webViewController pushURL:url title:title];
}

- (void)loadURL:(NSString *)urlString title:(NSString *)title backTitle:(NSString *)backTitle {
    @strongify(self.webViewController, strongWebViewController);
    
    if (urlString) {
        NSURL *url = [self URLWithURLString:urlString];
        [strongWebViewController loadURL:url];
    }
    
    if (title) {
        strongWebViewController.title = title;
    }
}

#pragma mark - Share

- (void)shareTapped:(id)sender {
    NSArray *items = nil;
    
    if (self.shareTitle.length && self.shareText.length) {
        items = @[self.shareText, self.shareTitle];
    } else {
        items = @[self.shareText];
    }
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items
                                                                                         applicationActivities:nil];
    [self.webViewController presentViewController:activityViewController animated:YES completion:nil];
}

#pragma mark - External API

- (void)pushStateWithOptions:(NSDictionary *)options {
    NSString *title = options[kSDJSNavigationScriptTitleKey];
    NSString *backTitle = options[kSDJSNavigationScriptBackTitleKey];
    NSString *urlString = options[kSDJSNavigationScriptURLKey];
    NSURL *url = [self URLWithURLString:urlString];

    SDWebViewController *webViewController = [self.webViewController pushURL:url title:title];
   
    if (backTitle.length) {
        webViewController.navigationItem.backBarButtonItem.title = backTitle;
    }
    
    // add share button
    self.shareText = options[kSDJSNavigationScriptShareTextKey];
    self.shareTitle = options[kSDJSNavigationScriptShareTitleKey];
    
    
    if (self.shareText.length) {
        UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                   target:self
                                                                                   action:@selector(shareTapped:)];
        webViewController.navigationItem.rightBarButtonItem = shareItem;
    }
}

- (void)replaceStateWithOptions:(NSDictionary *)options {
    NSString *title = options[kSDJSNavigationScriptTitleKey];
    NSString *backTitle = options[kSDJSNavigationScriptBackTitleKey];
    NSString *urlString = options[kSDJSNavigationScriptURLKey];
    
    [self loadURL:urlString title:title backTitle:backTitle];
}

- (void)back {
    [self.webViewController.navigationController popViewControllerAnimated:YES];
}

@end
