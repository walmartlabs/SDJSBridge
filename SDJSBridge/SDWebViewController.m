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
#import "SDJSHandlerScript.h"

@interface SDWebViewController () <UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIImageView *placeholderView;
@property (nonatomic, strong) NSTimer *loadTimer;
@property (nonatomic, assign) BOOL sharedWebView;
@property (nonatomic, strong) NSURL *currentURL;
@property (nonatomic, strong) SDJSBridge *bridge;
@property (nonatomic, weak) SDJSHandlerScript *handlerScript;

@end

@implementation SDWebViewController

#pragma mark - Initialization

- (instancetype)init
{
    if ((self = [super init]))
    {
    }
    
    return self;
}

- (instancetype)initWithWebView:(UIWebView *)webView
{
    return [self initWithWebView:webView bridge:nil];
}

- (instancetype)initWithWebView:(UIWebView *)webView bridge:(SDJSBridge *)bridge
{
    if ((self = [super init]))
    {
        _webView = webView;
        _sharedWebView = YES;
        _bridge = bridge;

        if (!_bridge)
        {
            [self loadBridge];
        }
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

#pragma mark - Lifecycle methods

- (void)dealloc
{
    self.delegate = nil;
}

- (void)viewDidLoad
{
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
    
    [self recontainWebView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![self isMovingToParentViewController] && self.webView.superview != self.view)
    {
        self.webView.hidden = YES;
        [self recontainWebView];
        [self.webView goBack];
        self.webView.hidden = NO;
    }
    
    if (_bridge)
    {
        [self configureScriptObjects];
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

- (void)initializeController
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.webView.hidden = YES;
}

#pragma mark - URLs

- (NSURL *)url
{
    return [self.currentURL copy];
}

- (void)loadURL:(NSURL *)url
{
    self.currentURL = url;
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.currentURL]];
}

#pragma mark - Navigation

- (id)pushURL:(NSURL *)url title:(NSString *)title
{
    self.placeholderView.image = [self imageWithView:self.webView];
    
    SDWebViewController *webViewController = [[[self class] alloc] initWithWebView:self.webView bridge:self.bridge];
    webViewController.title = title;
    [self.navigationController pushViewController:webViewController animated:YES];
    [webViewController loadURL:url];
    return webViewController;
}

- (id)presentModalURL:(NSURL *)url title:(NSString *)title
{
    self.placeholderView.image = [self imageWithView:self.webView];
    
    SDWebViewController *webViewController = [[[self class] alloc] initWithWebView:self.webView bridge:self.bridge];
    webViewController.title = title;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:webViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
    
    [webViewController loadURL:url];
    
    return webViewController;
}

- (id)presentModalHTML:(NSString *)html title:(NSString *)title
{    
    SDWebViewController *webViewController = [[[self class] alloc] initWithWebView:nil bridge:self.bridge];
    webViewController.title = title;
    [webViewController.webView loadHTMLString:html baseURL:self.url];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:webViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
    
    return webViewController;
}

#pragma mark - SDJSBridge

- (void)loadBridge {
    self.bridge = [[SDJSBridge alloc] initWithWebView:self.webView];
    
    [self loadHandlerScript];
}

- (void)loadHandlerScript {
    // handler JS API
    SDJSHandlerScript *handlerScript = [[SDJSHandlerScript alloc] initWithWebViewController:self];
    [self.bridge addScriptObject:handlerScript name:SDJSHandlerScriptName];
    self.handlerScript = handlerScript;
}

- (void)addScriptObject:(NSObject<JSExport> *)object name:(NSString *)name
{
    [self.bridge addScriptObject:object name:name];
}

- (void)addScriptMethod:(NSString *)name block:(id)block
{
    [self.bridge addScriptMethod:name block:block];
}

- (void)configureScriptObjects
{
    // update parent web view controller reference in scripts
    for (NSString *scriptName in [_bridge scriptObjects]) {
        SDJSBridgeScript *script = [_bridge scriptObjects][scriptName];
        if ([script isKindOfClass:[SDJSBridgeScript class]]) {
            script.webViewController = self;
        }
    }
    
    @strongify(self.delegate, strongDelegate);
    
    if ([strongDelegate respondsToSelector:@selector(webViewControllerConfigureScriptObjects:)]) {
        [strongDelegate webViewControllerConfigureScriptObjects:self];
    }
}

- (JSValue *)evaluateScript:(NSString *)script {
    return [self.bridge evaluateScript:script];
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
                {
                    result = YES;
                }
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

- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext *)context
{
    [self.bridge configureContext:context];
    
    @strongify(self.delegate, strongDelegate);

    if ([strongDelegate respondsToSelector:@selector(webViewController:didCreateJavaScriptContext:)]) {
        [strongDelegate webViewController:self didCreateJavaScriptContext:context];
    }
}

#pragma mark - Web view events.

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
        _webView.delegate = self;
        
        [self loadBridge];
    }

    return _webView;
}

@end
