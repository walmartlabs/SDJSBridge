//
//  SDJSRegistryScannerAPI.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/7/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"

#import <JavaScriptCore/JavaScriptCore.h>

@class SDJSRegistryScannerAPI;

@protocol SDJSRegistryScannerAPIDelegate <NSObject>

- (void)registryScannerAPI:(SDJSRegistryScannerAPI *)registryScannerAPI presentBarcodeScannerWithCallback:(JSValue *)callback;
- (void)registryScannerAPI:(SDJSRegistryScannerAPI *)registryScannerAPI presentReceiptScannerWithCallback:(JSValue *)callback;

@end

@protocol SDJSRegistryScannerAPIExports <JSExport>

JSExportAs(presentBarcodeScanner, - (void)presentBarcodeScannerWithCallback:(JSValue *)callback);
JSExportAs(presentReceiptScanner, - (void)presentReceiptScannerWithCallback:(JSValue *)callback);

@end

@interface SDJSRegistryScannerAPI : SDJSBridgeScript <SDJSRegistryScannerAPIExports>

@property (nonatomic, weak) id<SDJSRegistryScannerAPIDelegate> delegate;

- (void)presentBarcodeScannerWithCallback:(JSValue *)callback;
- (void)presentReceiptScannerWithCallback:(JSValue *)callback;

@end

