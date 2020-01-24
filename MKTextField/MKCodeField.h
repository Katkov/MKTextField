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

@end

@interface MKCodeField : UIView <UITextFieldDelegate>

@property (nonatomic, strong) UIView *touchView;
@property (nonatomic, strong) NSMutableArray *underscoreViews;
@property (nonatomic, strong) NSMutableArray *digitFields;

@property (nonatomic) NSUInteger numberOfSymbols;
@property (nonatomic) CGFloat distanceBetweenSymbols;
@property (nonatomic) UIFont *font;
@property (nonatomic) UIColor *textColor;
@property (nonatomic) UIColor *dashColor;
@property (nonatomic) CGFloat dashHeight;
@property (nonatomic) BOOL shouldResignFirstResponderOnFinish;
@property (nonatomic) UIKeyboardType keyboardType;


//Delegate
@property (nonatomic, weak, nullable) id <MKCodeFieldDelegate> delegate;

//Get Code with the method
- (NSString*) getCode;

@end

NS_ASSUME_NONNULL_END
