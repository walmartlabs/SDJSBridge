//
//  SDJSRegistryScannerAPI.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/7/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeScript.h"

#import <JavaScriptCore/JavaScriptCore.h>

@protocol SDJSRegistryScannerAPIExports <JSExport>

JSExportAs(presentBarcodeScanner, - (void)presentBarcodeScannerWithCallback:(JSValue *)callback);
JSExportAs(presentReceiptScanner, - (void)presentReceiptScannerWithCallback:(JSValue *)callback);

@end

@interface SDJSRegistryScannerAPI : SDJSBridgeScript <SDJSRegistryScannerAPIExports>

- (void)presentBarcodeScannerWithCallback:(JSValue *)callback;
- (void)presentReceiptScannerWithCallback:(JSValue *)callback;

@end
