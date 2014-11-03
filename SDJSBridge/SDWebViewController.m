//
//  SDWebViewController.m
//  SDJSBridgeExample
//
//  Created by Brandon Sneed on 10/9/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDWebViewController.h"
#import "SDJSBridge.h"
#import "SDMacros.h"
#import "SDJSNavigationAPI.h"
#import "SDJSTopLevelAPI.h"

@interface SDWebViewController () <UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIImageView *placeholderView;
@property (nonatomic, strong) NSTimer *loadTimer;
@property (nonatomic, assign) BOOL sharedWebView;
@property (nonatomic, strong) NSURL *currentURL;
@property (nonatomic, strong) SDJSBridge *bridge;

@end

@implementation SDWebViewController

#pragma mark - Public methods

- (instancetype)init
{
    if ((self = [super init]))
    {
    }
    
    return self;
}

- (instancetype)initWithWebView:(UIWebView *)webView
{
    if ((self = [super init]))
    {
        _webView = webView;
        _sharedWebView = YES;
        _bridge = [[SDJSBridge alloc] initWithWebView:self.webView];
    }
    
    return self;
}

- (instancetype)initWithURL:(NSURL *)url
{
    if ((self = [super init]))
    {
        _currentURL = url;
        [self loadURL:_currentURL];
    }
    
    return self;
}

- (NSURL *)url
{
    return [self.currentURL copy];
}

- (void)loadURL:(NSURL *)url
{
    self.currentURL = url;
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.currentURL]];
}

- (void)initializeController
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.webView.hidden = YES;
}

#pragma mark - SDJSBridge

- (void)addScriptObject:(NSObject<JSExport> *)object name:(NSString *)name
{
    [self.bridge addScriptObject:object name:name];
}

- (void)addScriptMethod:(NSString *)name block:(void *)block
{
    [self.bridge addScriptMethod:name block:block];
}

#pragma mark - Lifecycle methods

- (void)dealloc
{
    self.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.autoresizesSubviews = YES;
    //self.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.placeholderView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    //self.placeholderView.translatesAutoresizingMaskIntoConstraints = NO;
    self.placeholderView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:self.placeholderView atIndex:0];

    [self initializeController];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView.backgroundColor = [UIColor whiteColor];
    
    // todo: allow delegate/subclass to have control over adding API bridge
    SDJSTopLevelAPI *api = [[SDJSTopLevelAPI alloc] initWithWebViewController:self];
    [self addScriptObject:api name:SDJSTopLevelAPIScriptName];

    [self recontainWebView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![self isMovingToParentViewController])
    {
        self.webView.hidden = YES;
        [self recontainWebView];
        [self.webView goBack];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL result = YES;
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        if ([request.URL.absoluteString isEqualToString:self.currentURL.absoluteString])
            return YES;
        
        @strongify(self.delegate, strongDelegate);
        
        if ([strongDelegate respondsToSelector:@selector(webViewController:shouldOpenRequest:)])
            result = [strongDelegate webViewController:self shouldOpenRequest:request];
        else
        {
            result = [self shouldHandleURL:request.URL];
            
            // handles link clicks through standard navigation mechanism.
            if (result)
            {
                if ([request.URL.scheme isEqualToString:@"https"] || [request.URL.scheme isEqualToString:@"http"])
                {
                    [self pushURL:request.URL title:nil];
                    result = NO;
                }
                else
                    result = YES;
            }
        }
    }
    
    // useful for debugging.
    //NSLog(@"navType = %d, url = %@", navigationType, request.URL);
    
    return result;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    @strongify(self.delegate, strongDelegate);
    
    if ([strongDelegate respondsToSelector:@selector(webViewControllerDidStartLoad:)])
        [strongDelegate webViewControllerDidStartLoad:self];
    
    [self webViewDidStartLoad];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = title;
    self.webView.hidden = NO;
    
    @strongify(self.delegate, strongDelegate);
    if ([strongDelegate respondsToSelector:@selector(webViewControllerDidFinishLoad:)])
        [strongDelegate webViewControllerDidFinishLoad:self];
    
    [self webViewDidFinishLoad];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self webViewDidFinishLoad];
}

- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext*) ctx
{
    [self.bridge configureContext:ctx];
}

#pragma mark - Subclasses should override.

- (void)webViewDidStartLoad
{
    // don't do anything, this is for subclasses.
}

- (void)webViewDidFinishLoad
{
    // don't do anything, this is for subclasses.
}

- (BOOL)shouldHandleURL:(NSURL *)url
{
    return YES;
}

#pragma mark - Utilities

- (UIImage *)imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

- (void)recontainWebView
{
    self.webView.delegate = self;

    CGRect frame = self.view.bounds;
    
    [self.webView removeFromSuperview];
    
    self.webView.frame = frame;
    self.webView.scrollView.contentInset = UIEdgeInsetsZero;
    [self.view addSubview:self.webView];
    
    self.placeholderView.frame = frame;
}

- (UIWebView *)webView
{
    if (!_webView)
    {
        _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _webView.scrollView.delaysContentTouches = NO;
        [_webView.scrollView setDecelerationRate:UIScrollViewDecelerationRateNormal];
        self.bridge = [[SDJSBridge alloc] initWithWebView:self.webView];
    }

    return _webView;
}

#pragma mark - Navigation

- (id)pushURL:(NSURL *)url title:(NSString *)title {
    self.placeholderView.image = [self imageWithView:self.webView];
    
    SDWebViewController *webViewController = [[[self class] alloc] initWithWebView:self.webView];
    webViewController.title = title;
    [self.navigationController pushViewController:webViewController animated:YES];
    [webViewController loadURL:url];
    return webViewController;
}

- (id)presentURL:(NSURL *)url title:(NSString *)title {
    self.placeholderView.image = [self imageWithView:self.webView];
    
    SDWebViewController *webViewController = [[[self class] alloc] initWithWebView:self.webView];
    webViewController.title = title;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:webViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
    [webViewController loadURL:url];
    return webViewController;
}

@end
