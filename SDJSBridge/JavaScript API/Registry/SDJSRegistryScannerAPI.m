//
//  SDJSRegistryScannerAPI.m
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/7/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSRegistryScannerAPI.h"
#import "SDMacros.h"

@implementation SDJSRegistryScannerAPI

- (void)presentBarcodeScannerWithCallback:(JSValue *)callback {
    @strongify(self.delegate, strongDelegate);
    
    if ([strongDelegate respondsToSelector:@selector(presentBarcodeScannerWithCallback:)]) {
        [strongDelegate registryScannerAPI:self presentBarcodeScannerWithCallback:callback];
    }
}

- (void)presentReceiptScannerWithCallback:(JSValue *)callback {
    @strongify(self.delegate, strongDelegate);
    
    if ([strongDelegate respondsToSelector:@selector(presentBarcodeScannerWithCallback:)]) {
        [strongDelegate registryScannerAPI:self presentReceiptScannerWithCallback:callback];
    }
}

@end
