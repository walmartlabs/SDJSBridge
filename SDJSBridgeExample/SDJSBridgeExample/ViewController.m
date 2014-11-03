//
//  ViewController.m
//  SDJSBridgeExample
//
//  Created by Brandon Sneed on 10/9/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "ViewController.h"
#import "SDWebViewController.h"
#import "SDJSTopLevelAPI.h"
#import "SDJSNavigationAPI.h"

@interface ViewController ()

@property (nonatomic, strong) SDJSTopLevelAPI *topLevelAPI;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Webview"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(pushWebControllerTest:)];
}

- (IBAction)pushWebControllerTest:(id)sender {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"example1" withExtension:@"html"];
    SDWebViewController *webViewController = [[SDWebViewController alloc] initWithURL:url];
    
    // create top level API
    self.topLevelAPI = [[SDJSTopLevelAPI alloc] initWithWebViewController:webViewController];
    [webViewController addScriptObject:self.topLevelAPI name:SDJSTopLevelAPIScriptName];
    
    [self.navigationController pushViewController:webViewController animated:YES];
}

@end
