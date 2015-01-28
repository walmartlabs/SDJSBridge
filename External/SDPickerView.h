//
//  SDPickerView.h
//
//  Created by Douglas Pedley on 12/13/13.
//  Copyright (c) 2013 SetDirection. All rights reserved.
//

#import "ObjectiveCGenerics.h"
#import "NSString+SDExtensions.h"

#import <UIKit/UIKit.h>

typedef void(^SDPickerViewDateCompletionBlock)(BOOL canceled, NSDate *selectedDate);
typedef void(^SDPickerViewItemSelectionCompletionBlock)(BOOL canceled, NSInteger selectedItemIndex, NSString *selectedItem);

@class SDPickerView;

@protocol SDPickerViewDelegate <NSObject>
@optional
- (void)pickerViewDidShow:(SDPickerView *)pickerView;
- (void)pickerViewWillShow:(SDPickerView *)pickerView;
@end


@interface SDPickerView : UIButton

-(void)configureAsDatePickerWithCompletion:(SDPickerViewDateCompletionBlock)completion;
-(void)configureAsDatePicker:(NSDate *)initialDate completion:(SDPickerViewDateCompletionBlock)completion;
-(void)configureAsDatePicker:(NSDate *)initialDate datePickerMode:(UIDatePickerMode)datePickerMode completion:(SDPickerViewDateCompletionBlock)completion;

-(void)configureAsItemPicker:(NSArray<NSString>*)items completion:(SDPickerViewItemSelectionCompletionBlock)completion;
-(void)configureAsItemPicker:(NSArray<NSString>*)items initialItem:(NSInteger)selectedItem completion:(SDPickerViewItemSelectionCompletionBlock)completion;

@property (nonatomic, weak) id<SDPickerViewDelegate> delegate;

@end
