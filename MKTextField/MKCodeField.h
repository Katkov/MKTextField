//
//  MKCodeField.h
//  MKTextField
//
//  Created by Michael Katkov on 1/23/20.
//  Copyright © 2020 Michael Katkov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKCodeFieldDelegate
@required

- (void)mkCodeFieldEndEditing: (NSString *)code;
- (void)mkCodeFieldProcessEditing: (NSString *)code;

@end

@interface MKCodeField : UIView <UITextFieldDelegate>

@property (nonatomic, strong) UIView *touchView;
@property (nonatomic, strong) NSMutableArray *underscoreViews;
@property (nonatomic, strong) NSMutableArray *digitFields;

//Label delimeters
@property (nonatomic, strong) NSMutableArray *delimeterLabels;

@property (nonatomic) NSUInteger numberOfSymbols;
@property (nonatomic) CGFloat distanceBetweenSymbols;
@property (nonatomic) UIFont *font;
@property (nonatomic) UIColor *textColor;
@property (nonatomic) UIColor *dashColor;
@property (nonatomic) CGFloat dashHeight;
@property (nonatomic) BOOL shouldResignFirstResponderOnFinish;
@property (nonatomic) UIKeyboardType keyboardType;

//delimeter position to delimeter symbol
@property (nonatomic, nullable) NSDictionary *delimeters;
@property (nonatomic, nullable) UIColor *delimeterColor;
@property (nonatomic, nullable) UIFont *delimeterFont;

@property (nonatomic, nullable) NSString *allowedCharactersSet;

//Delegate
@property (nonatomic, weak, nullable) id <MKCodeFieldDelegate> delegate;

//Get Code with the method
- (NSString*) getCode;

@end

NS_ASSUME_NONNULL_END
