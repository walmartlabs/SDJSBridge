//
//  SDJSRegistryAPI.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/7/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"

#import "SDJSRegistryScannerAPI.h"

#import <JavaScriptCore/JavaScriptCore.h>

@protocol SDJSRegistryAPIExports <JSExport>

@property (nonatomic, strong) SDJSRegistryScannerAPI *scanner;

@end

@interface SDJSRegistryAPI : SDJSBridgeScript

@property (nonatomic, strong) SDJSRegistryScannerAPI *scanner;

@end
