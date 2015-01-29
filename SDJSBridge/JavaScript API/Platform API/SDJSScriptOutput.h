//
//  SDJSScriptOutput.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 1/29/15.
//  Copyright (c) 2015 SetDirection. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Helper class for generating bridge script output.
 */
@interface SDJSScriptOutput : NSObject

/**
 Return the action value for cancelled status.
 */
+ (NSString *)actionForCancelled:(BOOL)cancelled;

@end
