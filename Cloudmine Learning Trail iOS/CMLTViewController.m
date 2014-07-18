//
//  CMLTViewController.m
//  Cloudmine Learning Trail iOS
//
//  Created by Charles Burnett on 7/17/14.
//  Copyright (c) 2014 CloudMine. All rights reserved.
//

#import "CMLTViewController.h"

@interface CMLTViewController ()

@end

@implementation CMLTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _PasswordTextField) {
        [textField resignFirstResponder];
    } else if (textField == _EmailTextField) {
        [self.PasswordTextField becomeFirstResponder];
    }
    return YES;
}

@end
