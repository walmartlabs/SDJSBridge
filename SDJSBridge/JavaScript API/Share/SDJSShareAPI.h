//
//  SDJSShareAPI.h
//  SDJSBridgeExample
//
//  Created by Angelo Di Paolo on 11/12/14.
//  Copyright (c) 2014 SetDirection. All rights reserved.
//

#import "SDJSBridgeResponder.h"

#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>

/**
 A delegate protocol for interacting with a SDJSShareAPI object. Allows for 
 customization over the UIActivityViewController that is used to share an item.
 */
@protocol SDJSShareAPIDelegate <NSObject>

/**
 Implement to customize the activity items that are being shared.
 @param url URL of the item being shared.
 @param message Message text of the item being shared.
 @return An array of the activity items that will be used for the UIActivityViewController.
 */
- (NSArray *)shareBridgeAPIActivityItemsWithURL:(NSURL *)url message:(NSString *)message;

/**
 Implement to customize the application activities that are used for the UIActivityViewController.
 @param url URL of the item being shared.
 @param message Message text of the item being shared.
 @return An array of the application activities that will be used for the UIActivityViewController.
 */
- (NSArray *)shareBridgeAPIApplicationActivitiesWithURL:(NSURL *)url message:(NSString *)message;

/**
 Implement to provide the excluded activity types that are used for the UIActivityViewController.
 @param url URL of the item being shared.
 @param message Message text of the item being shared.
 @return An array of the excluded activity types that will be used for the UIActivityViewController.
 */
- (NSArray *)shareBridgeAPIExcludedActivityTypesWithURL:(NSURL *)url message:(NSString *)message;

/**
 Implement to customize how the UIActivityViewController is presented.
 @param activityViewController The UIActivityViewController instance
 */
- (void)shareBridgeAPIPresentActivityViewController:(UIActivityViewController *)activityViewController;

/**
 Implement to customize the completion logic.
 @return The completion handler block of type UIActivityViewControllerCompletionHandler.
 */
- (UIActivityViewControllerCompletionHandler)shareBridgeAPICompletionHandler;

@end

/**
 A JavaScript bridge script for sharing a URL and message with a
 UIActivityViewController. The class has built-in support for configuring and 
 presenting a UIActivityViewController but the behavior can be customized by
 setting the delegate property and implementing methods of the SDJSShareAPIDelegate
 protocol.

 ## Usage
 
 ### Objective-C

 Set the delegate property to customize the UIActivityViewController behavior.

     SDWebViewController *webViewController;
     SDJSShareAPI *shareAPI = [[SDJSShareAPI alloc] initWithWebViewController:webViewController];
     shareAPI.delegate = self;

 Implement the delegate methods to make customizations.

     #pragma mark - SDJSShareAPIDelegate

     - (NSArray *)shareBridgeAPIActivityItemsWithURL:(NSURL *)url message:(NSString *)message {
         return @[message, url];
     }
     
     - (void)shareBridgeAPIPresentActivityViewController:(UIActivityViewController *)activityViewController {
         [self presentViewController:activityViewController animated:YES completion:nil];
     }


 ### JavaScript
 
 Sharing a URL with a message.
 
     var url = "http://www.walmart.com/";
     var message = "Check out this great deal!"
     
     JSBridgeAPI.platform().share(url, message, function () {
       // share complete
     });
 
 
 */
@interface SDJSShareAPI : SDJSBridgeResponder <SDJSShareAPIDelegate>

/**
 By default an instance of SDJSShareAPI makes itself the delegate. Set to 
 customize share behavior.
 */
@property (nonatomic, weak) id<SDJSShareAPIDelegate> delegate;

/**
 Share an item with a URL and message.
 @param url URL of the item being shared.
 @param message Message text of the item being shared.
 @param url URL of the item being shared.
 @param excludedServices Array of share services (SDJSShareService instances) to
 exclude.
 */
- (void)shareWithURL:(NSURL *)url message:(NSString *)message excludedServices:(NSArray *)excludedServices;

@end
