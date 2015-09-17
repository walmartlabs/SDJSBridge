////
////  UIWebView+SDJSExtensions.m
////  SDJSBridgeExample
////
////  Created by Brandon Sneed on 10/9/14.
////  Copyright (c) 2014 SetDirection. All rights reserved.
////
////  Based on UIWebView+TS_JavaScriptContext by Nicholas Hodapp
////  Copyright (c) 2013 CoDeveloper, LLC.
//
//#import "UIWebView+SDJSExtensions.h"
//
//#import <JavaScriptCore/JavaScriptCore.h>
//#import <objc/runtime.h>
//
//static NSString *const kSDJSContext = @"sdjs_context";
//
//static NSHashTable *g_webViews = nil;
//
//@interface UIWebView (SDJSPrivate)
//- (void) sdjs_didCreateContext:(JSContext *)ts_javaScriptContext;
//@end
//
//@implementation NSObject(SDJSJavaScriptContext)
//
//- (void)webView:(id)unused didCreateJavaScriptContext:(JSContext *)aContext forFrame:(id)frame
//{
//    if (![frame isKindOfClass:NSClassFromString(@"WebFrame")])
//        return;
//    
//    void (^notifyDidCreateJavaScriptContext)() = ^{
//        for (UIWebView *webView in g_webViews)
//        {
//            NSString *cookie = [NSString stringWithFormat:@"ts_jscWebView_%lud", (unsigned long)webView.hash];
//            [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat: @"var %@ = '%@'", cookie, cookie]];
//            
//            if ([aContext[cookie].toString isEqualToString:cookie])
//            {
//                [webView sdjs_didCreateContext:aContext];
//                return;
//            }
//        }
//    };
//    
//    if ([NSThread isMainThread])
//        notifyDidCreateJavaScriptContext();
//    else
//        dispatch_async(dispatch_get_main_queue(), notifyDidCreateJavaScriptContext);
//}
//
//@end
//
//
//@implementation UIWebView(SDJSExtensions)
//
//+ (id)allocWithZone:(struct _NSZone *)zone
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        g_webViews = [NSHashTable weakObjectsHashTable];
//    });
//    
//    NSAssert([NSThread isMainThread], @"This should only run via the main thread.");
//    
//    id webView = [super allocWithZone:zone];
//    [g_webViews addObject:webView];
//    
//    return webView;
//}
//
//- (void)sdjs_didCreateContext:(JSContext *)aContext
//{
//    [self willChangeValueForKey:kSDJSContext];
//    objc_setAssociatedObject(self, kSDJSContext.UTF8String, aContext, OBJC_ASSOCIATION_RETAIN);
//    [self didChangeValueForKey:kSDJSContext];
//    
//    if ([self.delegate respondsToSelector:@selector(webView:didCreateJavaScriptContext:)])
//    {
//        id<SDJSWebViewDelegate> delegate = (id<SDJSWebViewDelegate>)self.delegate;
//        [delegate webView:self didCreateJavaScriptContext:aContext];
//    }
//}
//
//- (JSContext *)sdjs_context
//{
//    JSContext *javaScriptContext = objc_getAssociatedObject(self, kSDJSContext.UTF8String);
//    return javaScriptContext;
//}
//
//@end