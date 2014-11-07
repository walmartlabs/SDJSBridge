//
//  SDJSBridgeResponder.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/4/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol SDJSBridgeResponderExports <JSExport>

@property (nonatomic, strong) JSValue *callback;

@end

/**
 An abstract class for representing a JavaScript bridge script that invokes a
 callback when performing an action.
 */
@interface SDJSBridgeResponder : NSObject <SDJSBridgeResponderExports>

@property (nonatomic, strong) JSValue *callback;
@property (nonatomic, readonly) SEL actionSelector;

- (instancetype)initWithCallback:(JSValue *)callback;
- (void)performActionWithSender:(id)sender;
- (SEL)actionSelector;

@end
