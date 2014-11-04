//
//  SDJSAlertAction.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/4/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol SDJSAlertActionExports <JSExport>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) JSValue *callback;

@end

@interface SDJSAlertAction : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) JSValue *callback;

+ (instancetype)alertActionWithTitle:(NSString *)title callback:(JSValue *)callback;
- (void)itemTapped:(id)sender;

@end
