//
//  SDJSAlertScriptOutput.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/26/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol SDJSAlertScriptOutputExports <JSExport>

@property (nonatomic, copy, readonly) NSString *action;

@end

@interface SDJSAlertScriptOutput : NSObject <SDJSAlertScriptOutputExports>

@property (nonatomic, copy, readonly) NSString *action;

- (instancetype)initWithAction:(NSString *)action;

@end
