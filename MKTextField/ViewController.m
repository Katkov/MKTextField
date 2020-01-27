//
//  ViewController.m
//  MKTextField
//
//  Created by Michael Katkov on 1/23/20.
//  Copyright © 2020 Michael Katkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Phone Field
    MKCodeField *phoneField = [[MKCodeField alloc] init];
    phoneField.numberOfSymbols = 14;
    phoneField.distanceBetweenSymbols = 6.0f;
    phoneField.dashColor = [UIColor blackColor];
    phoneField.dashHeight = 5.0f;
    phoneField.font = [UIFont fontWithName:@"Arial" size:26.0];
    phoneField.shouldResignFirstResponderOnFinish = true;
    phoneField.textColor = [UIColor blueColor];
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    phoneField.delegate = self;
    phoneField.delimeters = @{ @"0" : @"(", @"4" : @")", @"5" : @" ", @"9" : @"-"};
    phoneField.delimeterColor = [UIColor blueColor];
    phoneField.delimeterFont = [UIFont fontWithName:@"Arial" size:38.0];
    phoneField.allowedCharactersSet = @" 01234567";
    phoneField.toolBar = [self getToolbar];
    [phoneField setFrame:CGRectMake(20, 200, 320, 40)];
    [self.view addSubview:phoneField];
    
    // Code Field
    MKCodeField *codeField = [[MKCodeField alloc] init];
    codeField.numberOfSymbols = 6;
    codeField.distanceBetweenSymbols = 10.0f;
    codeField.dashColor = [UIColor blueColor];
    codeField.dashHeight = 5.0f;
    codeField.font = [UIFont fontWithName:@"Arial" size:26.0];
    codeField.shouldResignFirstResponderOnFinish = true;
    codeField.textColor = [UIColor blackColor];
    codeField.keyboardType = UIKeyboardTypeNumberPad;
    codeField.delegate = self;
    [codeField setFrame:CGRectMake(40, 40, 200, 40)];
    [self.view addSubview:codeField];
}

-(void)mkCodeFieldEndEditing:(NSString *)code
{
    NSLog(@"End editing %@", code);
}

-(void)mkCodeFieldProcessEditing:(NSString *)code
{
    NSLog(@"Process editing %@", code);
}

- (UIToolbar*)getToolbar
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = [NSArray arrayWithObjects:
                                   [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                                   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                   [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                                   nil];
    [numberToolbar sizeToFit];
    return numberToolbar;
}

- (void)cancelNumberPad
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)doneWithNumberPad
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}


@end
