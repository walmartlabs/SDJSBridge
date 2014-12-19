//
//  SDJSBridge.m
//  SDJSBridgeExample
//
//  Created by Brandon Sneed on 10/9/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridge.h"
#import "SDJSHandlerScript.h"
@import JavaScriptCore;

@interface SDJSBridge ()

@property (nonatomic, readonly) JSContext *context;
@property (nonatomic, strong) SDJSHandlerScript *handlerScript;
@property (nonatomic, strong) NSMutableDictionary *handlerObjects;

@end

static NSString * const SDJSBridgeException = @"SDJSBridgeException";

static NSString * const UIWebViewContextPath = @"documentView.webView.mainFrame.javaScriptContext";

@implementation SDJSBridge
{
    NSMutableDictionary *_scriptObjects;
    UIWebView *_webView;
}

#pragma mark - Lifecycle

- (instancetype)init
{
    if ((self = [super init]))
    {
        _context = [[JSContext alloc] initWithVirtualMachine:[[JSVirtualMachine alloc] init]];
        [self configureContext:_context];
    }
    return self;
}

- (instancetype)initWithWebView:(UIWebView *)webView
{
    if ((self = [super init]))
    {
        _context = [webView valueForKeyPath:UIWebViewContextPath];
        _webView = webView;
        [_webView addObserver:self forKeyPath:UIWebViewContextPath options:NSKeyValueObservingOptionNew context:nil];
        [self configureContext:_context];
    }
    return self;
}

- (void)dealloc
{
    if (_webView)
        [_webView removeObserver:self forKeyPath:UIWebViewContextPath];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (!_webView)
        return;
    
    // we want to know if the webView's context changes.
    if ([keyPath isEqualToString:UIWebViewContextPath])
    {
        NSLog(@"context changed");
    }
}

#pragma mark - Script API

- (void)configureContext:(JSContext *)context
{
    _context = context;
    
    [_context setExceptionHandler:^(JSContext *aContext, JSValue *value) {
        NSLog(@"SDJSBridgeException: %@", value);
    }];
    
    [_scriptObjects enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        self.context[key] = obj;
    }]; 
}

- (void)addScriptObject:(NSObject<JSExport> *)object name:(NSString *)name
{
    if (![[object class] conformsToProtocol:@protocol(JSExport)])
        [NSException raise:SDJSBridgeException format:@"object does not conform to the JSExport protocol!"];
    
    if (!_scriptObjects)
        _scriptObjects = [[NSMutableDictionary alloc] init];
    [_scriptObjects setObject:object forKey:name];
    self.context[name] = object;
}

- (void)addScriptMethod:(NSString *)name block:(id)block
{
    self.context[name] = block;
}

- (JSValue *)evaluateScript:(NSString *)script
{
    JSValue *value = [self.context evaluateScript:script];
    
    return value;
}

- (JSValue *)scriptValueForName:(NSString *)name
{
    return self.context[name];
}

- (NSDictionary *)scriptObjects {
    return _scriptObjects;
}

#pragma mark - 

- (void)registerHandlerWithName:(NSString *)handlerName handler:(SDBridgeHandlerBlock)handler {
    if (!self.handlerScript) {
        self.handlerScript = [[SDJSHandlerScript alloc] init];
        [self addScriptObject:self.handlerScript name:@"WebViewJavascriptBridge"];
    }
    
    [self.handlerScript registerHandlerWithName:handlerName handler:handler];
}

- (void)addHandlerObject:(NSObject<SDJSBridgeHandler> *)object
{
    if (![[object class] conformsToProtocol:@protocol(SDJSBridgeHandler)]) {
        [NSException raise:SDJSBridgeException format:@"object does not conform to the SDJSBridgeHandler protocol!"];
    }
    
    NSString *handlerName = [object handlerName];
    self.handlerObjects[handlerName] = object;
    
    [self registerHandlerWithName:handlerName handler:^(JSValue *data, SDBridgeHandlerCallbackBlock callback) {
        [object callHandlerWithData:data callback:callback];
    }];
}

@end
