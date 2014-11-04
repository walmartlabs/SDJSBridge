//
//  SDJSAlertAction.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/4/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeResponder.h"

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol SDJSAlertActionExports <JSExport>

@property (nonatomic, copy) NSString *title;

@end

@interface SDJSAlertAction : SDJSBridgeResponder <SDJSAlertActionExports>

@property (nonatomic, copy) NSString *title;

+ (instancetype)alertActionWithTitle:(NSString *)title callback:(JSValue *)callback;

@end
