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

@interface SDWebViewController () <UIWebViewDelegate>
@property (nonatomic, readonly) UIWebView *webView;
@property (nonatomic, strong) UIImageView *placeholderView;
@end

@implementation SDWebViewController
{
    NSURL *_currentURL;
    SDJSBridge *_bridge;
    BOOL _sharedWebView;
    NSTimer *_loadTimer;
    UIWebView *_webView;
}

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
    }
    
    return self;
}

- (NSURL *)url
{
    return [_currentURL copy];
}

- (void)loadURL:(NSURL *)url
{
    _currentURL = url;
    [self.webView loadRequest:[NSURLRequest requestWithURL:_currentURL]];
    
    [self invalidateTimer];
}

- (void)initializeController
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.webView.hidden = YES;
}

- (void)addScriptObject:(NSObject<JSExport> *)object name:(NSString *)name
{
    [_bridge addScriptObject:object name:name];
}

- (void)addScriptMethod:(NSString *)name block:(void *)block
{
    [_bridge addScriptMethod:name block:block];
}

#pragma mark - Lifecycle methods

- (void)dealloc
{
    [self invalidateTimer];
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
    
    [self recontainWebView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![self isMovingToParentViewController])
    {
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
        if ([request.URL.absoluteString isEqualToString:_currentURL.absoluteString])
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
                    self.placeholderView.image = [self imageWithView:self.webView];
                    
                    id webViewController = [[[self class] alloc] initWithWebView:self.webView];
                    [self.navigationController pushViewController:webViewController animated:YES];
                    [webViewController loadURL:request.URL];

                    result = NO;
                }
                else
                    result = YES;
            }
        }
    }
    else if (navigationType == UIWebViewNavigationTypeOther)
    {
        if (!_loadTimer)
        {
            _loadTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(checkLoadingStatus:) userInfo:nil repeats:YES];
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
    [self invalidateTimer];
    
    @strongify(self.delegate, strongDelegate);
    
    if ([strongDelegate respondsToSelector:@selector(webViewControllerDidFinishLoad:)])
        [strongDelegate webViewControllerDidFinishLoad:self];
    
    [self webViewDidFinishLoad];
}

- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext*) ctx
{
    [_bridge configureContext:ctx];
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
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

- (void)invalidateTimer
{
    [_loadTimer invalidate];
    _loadTimer = nil;
}

- (void)checkLoadingStatus:(NSTimer *)timer
{
    if (!self.webView.loading)
    {
        // they likely left the app due to some redirected url like to iTunes or something.
        [self.webView stopLoading];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
        [self invalidateTimer];
    }
    
    // useful code for debugging.
    /*if (self.webView.loading)
        NSLog(@"loading = YES");
    else
        NSLog(@"loading = NO");*/
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
        //_webView.translatesAutoresizingMaskIntoConstraints = NO;
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _webView.scrollView.delaysContentTouches = NO;
        [_webView.scrollView setDecelerationRate:UIScrollViewDecelerationRateNormal];
        
        _bridge = [[SDJSBridge alloc] initWithWebView:self.webView];
    }

    return _webView;
}

@end
