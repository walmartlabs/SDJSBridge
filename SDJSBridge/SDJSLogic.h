//
//  SDJSLogic.h
//  walmart
//
//  Created by Brandon Sneed on 2/4/15.
//  Copyright (c) 2015 Walmart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface SDJSLogic : NSObject


+ (void)subscribeName:(NSString *)name toURL:(NSURL *)url;

+ (JSContext *)contextForName:(NSString *)name;

@end
