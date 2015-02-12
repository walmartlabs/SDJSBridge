//
//  SDJSLogic.m
//  walmart
//
//  Created by Brandon Sneed on 2/4/15.
//  Copyright (c) 2015 Walmart. All rights reserved.
//

#import "SDJSLogic.h"
#import "SDURLConnection.h"
#import "NSData+SDExtensions.h"
#import "SDMacros.h"

@import JavaScriptCore;


@interface SDJSLogic ()
@property (nonatomic, strong) NSCache *namedContexts;
@property (nonatomic, assign) NSInteger *subscriptionsInFlight;
@end


@implementation SDJSLogic

+ (void)subscribeName:(NSString *)name toURL:(NSURL *)url
{
    [[self sharedInstance] subscribeName:name toURL:url];
}

+ (JSContext *)contextForName:(NSString *)name
{
    return [[self sharedInstance] contextForName:name];
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t oncePred;
    static id sharedInstance = nil;
    dispatch_once(&oncePred, ^{ sharedInstance = [[[self class] alloc] init]; });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    
    // use NSCache since it's thread safe.
    _namedContexts = [[NSCache alloc] init];
    _subscriptionsInFlight = 0;
    
    return self;
}

- (void)subscribeName:(NSString *)name toURL:(NSURL *)url
{
    // has someone already requested this url/name?
    id existingContext = [self.namedContexts objectForKey:name];
    if (existingContext)
        return;
    
    // reserve our name
    [self.namedContexts setObject:[NSNull null] forKey:name];
    self.subscriptionsInFlight++;
    
    // fetch the url that was requested
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    @weakify(self);
    [SDURLConnection sendAsynchronousRequest:request withResponseHandler:^(SDURLConnection *connection, NSURLResponse *response, NSData *responseData, NSError *error) {
        @strongify(self);
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (!error && responseData && httpResponse.statusCode == 200)
        {
            [self storeLogic:responseData name:name];
        }
        else
        {
            // remove our reserved named since it failed.
            [self.namedContexts removeObjectForKey:name];
        }
        
        self.subscriptionsInFlight--;
    }];
}

- (JSContext *)contextForName:(NSString *)name
{
    JSContext *result = [self.namedContexts objectForKey:name];
    return result;
}

- (void)storeLogic:(NSData *)logic name:(NSString *)name
{
    // turn the data to a string, ie: back to javascript
    
    NSString *logicString = [logic stringRepresentation];
    
    // i can't find a place to host the file where i just get a raw version back.
    //NSString *logicString = @"var isTahoeCapable = function(output) { if (output % 2 == 0) { return true } else { return false } }";
    
    // create our context we'll use.  state should persist within.
    JSContext *context = [[JSContext alloc] initWithVirtualMachine:[[JSVirtualMachine alloc] init]];
    [context evaluateScript:logicString];
    
    [self.namedContexts setObject:context forKey:name];
}

@end
