//
//  MKCodeField.m
//  MKTextField
//
//  Created by Michael Katkov on 1/23/20.
//  Copyright © 2020 Michael Katkov. All rights reserved.
//

#import "MKCodeField.h"

@implementation MKCodeField

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    // UIView will be "transparent" for touch events if we return NO
    return YES;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    //remove all subviews
    for (UIView* v in self.subviews) [v removeFromSuperview];
    //calculate width
    CGFloat width = (self.frame.size.width - (CGFloat)self.distanceBetweenSymbols * ((CGFloat)self.numberOfSymbols - 1.0f)) / (CGFloat)self.numberOfSymbols;
    //init fields
    [self initDigitFieldsWithWidth:width];
    //init labels
    [self initUnderscoreViewsWithWidth:width];
    //init touchView
    [self initTouchView:CGRectMake(0, 0, frame.size.width, frame.size.height)];
}

-(void) tapDetected:(UITapGestureRecognizer*)sender
{
    UITextField *textField = [self firstEmptyOrLast];
    [textField becomeFirstResponder];
}

- (void) initTouchView:(CGRect)frame
{
    self.touchView = [[UIView alloc] initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    //set listener
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    tap.numberOfTapsRequired = 1;
    [self.touchView setUserInteractionEnabled:YES];
    [self.touchView addGestureRecognizer: tap];
    [self addSubview:self.touchView];
    [self bringSubviewToFront:self.touchView];
}

- (void) initDigitFieldsWithWidth:(CGFloat) width
{
    self.digitFields = [NSMutableArray array];
    self.delimeterLabels = [NSMutableArray array];
    for (int i = 0; i < self.numberOfSymbols; i++) {
        //Try to retrive delimeter
        NSString *key = [NSString stringWithFormat:@"%d", i];
        if (self.delimeters != NULL && self.delimeters[key] != NULL) {
            UILabel *delimeterLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * width + i * self.distanceBetweenSymbols, 0, width, self.frame.size.height * 0.9f)];
            delimeterLabel.text = self.delimeters[key];
            delimeterLabel.textColor = self.delimeterColor;
            delimeterLabel.textAlignment = NSTextAlignmentCenter;
            delimeterLabel.font = self.delimeterFont;
            [self addSubview:delimeterLabel];
            [self.delimeterLabels addObject:delimeterLabel];
        } else {
            UITextField *textField = [[UITextField alloc] initWithFrame: CGRectMake(i * width + i * self.distanceBetweenSymbols, 0, width, self.frame.size.height * 0.8f)];
            textField.borderStyle = UITextBorderStyleNone;
            textField.font = self.font;
            textField.textColor = self.textColor;
            textField.autocorrectionType = UITextAutocorrectionTypeNo;
            textField.keyboardType = self.keyboardType;
            textField.returnKeyType = UIReturnKeyDefault;
            textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            textField.textAlignment = NSTextAlignmentCenter;
            textField.tag = i;
            textField.delegate = self;
            [self addSubview:textField];
            [self.digitFields addObject:textField];
        }
    }
}

- (void) initUnderscoreViewsWithWidth:(CGFloat) width
{
    self.underscoreViews = [NSMutableArray array];
    for (int i = 0; i < self.numberOfSymbols; i++) {
        //Try to retrive delimeter
        NSString *key = [NSString stringWithFormat:@"%d", i];
        if (self.delimeters != NULL && self.delimeters[key] != NULL) {
            continue;
        }
        //If OK, set up view
        UIView *view = [[UIView alloc] initWithFrame: CGRectMake(i * width + i * self.distanceBetweenSymbols, self.frame.size.height * 0.85f, width, self.dashHeight)];
        view.backgroundColor = self.dashColor;
        [self addSubview: view];
        [self.underscoreViews addObject:view];
    }
}

- (UITextField*) next:(UITextField*) textField
{
    for (int i = 0; i < self.digitFields.count; i++) {
        UITextField *this = self.digitFields[i];
        if (this.tag == textField.tag && i + 1 < self.digitFields.count) {
            return self.digitFields[i + 1];
        }
    }
    return NULL;
}

- (UITextField*) previous:(UITextField*) textField
{
    for (int i = 0; i < self.digitFields.count; i++) {
        UITextField *this = self.digitFields[i];
        if (this.tag == textField.tag && i - 1 >= 0) {
            return self.digitFields[i - 1];
        }
    }
    return NULL;
}

- (UITextField*) firstEmptyOrLast
{
    for (int i = 0; i < self.digitFields.count; i++) {
        UITextField *textField = self.digitFields[i];
        if ([textField.text isEqualToString:@""] || [textField.text isEqualToString:@" "]) {
            return textField;
        }
    }
    return self.digitFields[self.digitFields.count - 1];
}

- (NSString*) getCode
{
    NSString *result = @"";
    for(int i=0; i < self.digitFields.count; i++) {
        UITextField *textField = self.digitFields[i];
        result = [result stringByAppendingString: textField.text];
    }
    return result;
}

//DELEGATE START
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *space = @" ";
    NSString *empty = @"";
    const char * _char = [string cStringUsingEncoding:NSUTF8StringEncoding];
    int isBackSpace = strcmp(_char, "\b");

    if (isBackSpace == -8) {
        if ([textField.text isEqualToString:space]) {
            UITextField *previous = [self previous:textField];
            if (previous != NULL) {
                if ([textField.text isEqualToString:space]) {
                    [previous setText:space];
                }
                [previous becomeFirstResponder];
            }
        }
        [textField setText:space];
    } else {
        if ([textField.text isEqualToString:space] || [textField.text isEqualToString:empty]) {
            [textField setText:string];
        }
        UITextField *next = [self next:textField];
        if (next != NULL) {
            [next setText:space];
            [next becomeFirstResponder];
        } else {
            if (self.shouldResignFirstResponderOnFinish) {
                [textField resignFirstResponder];
                if (self.delegate) [self.delegate mkCodeFieldEndEditing:self.getCode];
            }
        }
    }
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self next:textField] != NULL) {
        return NO;
    }
    //If last test field but empty
    if ([textField.text isEqualToString:@""] || [textField.text isEqualToString:@" "]) {
        return NO;
    }
    //If last and filled
    [textField resignFirstResponder];
    if (self.delegate) [self.delegate mkCodeFieldEndEditing:self.getCode];
    return YES;
}
//DELEGATE END

@end
