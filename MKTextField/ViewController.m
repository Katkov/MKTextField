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
    
    // Code Field
    MKCodeField *codeField = [[MKCodeField alloc] init];
    codeField.numberOfSymbols = 6;
    codeField.distanceBetweenSymbols = 10.0f;
    codeField.dashColor = [UIColor blueColor];
    codeField.dashHeight = 5.0f;
    codeField.font = [UIFont fontWithName:@"Arial" size:26.0];
    codeField.shouldResignFirstResponderOnFinish = true;
    codeField.textColor = [UIColor blackColor];
    codeField.keyboardType = UIKeyboardTypeNamePhonePad;
    codeField.delegate = self;
    [codeField setFrame:CGRectMake(40, 40, 200, 40)];
    [self.view addSubview:codeField];
    
    // Phone Field
}

-(void)mkCodeFieldEndEditing:(NSString *)code
{
    NSLog(@"%@", code);
}

@end
