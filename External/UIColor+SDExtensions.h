//
//  UIColor+SDExtensions.h
//  SetDirection
//
//  Created by Sam Grover on 3/19/11.
//  Copyright 2011 SetDirection. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIColor (SDExtensions)

/**
 A convenience method to create and return a UIColor object using the standard RGB values that range from `0.0` to `255.0` each.
 */
+ (UIColor *)colorWith8BitRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha;

/*
 * Returns a UIColor objects for the string's hex representation:
 *
 * For example: [@"#fff" uicolor] returns a UIColor of white.
 *              [@"#118653" uicolor] returns something green.
 *              [@"#1186537F" uicolor] returns something green with a 50% alpha value
 */
+ (UIColor *)colorWithHexValue:(NSString *)hexValueString;

/**
* Creates a color with random color values and alpha of 1.0
*
* @return A UIColor with random color values
*/
+ (UIColor *)randomColor;
@end
