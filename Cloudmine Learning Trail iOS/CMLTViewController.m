//
//  CMLTViewController.m
//  Cloudmine Learning Trail iOS
//
//  Created by Charles Burnett on 7/17/14.
//  Copyright (c) 2014 CloudMine. All rights reserved.
//

#import "CMLTViewController.h"
#import <CloudMine/CloudMine.h>
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

- (IBAction)login:(id)sender {
    CMUser *user = [[CMUser alloc] initWithEmail:[_EmailTextField text] andPassword:[_PasswordTextField text]];
    UIAlertView * passwordAlert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Invalid Credentials" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    UIAlertView * existenceAlert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"An account with those credentials does not exist" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];

    // You can use "anotherUser" here in the same way!
    [user loginWithCallback:^(CMUserAccountResult resultCode, NSArray *messages) {
        switch(resultCode) {
            case CMUserAccountLoginSucceeded:
                // success! the user now has a session token
                [self performSegueWithIdentifier:@"loginSegue" sender:nil];
                break;
            case CMUserAccountLoginFailedIncorrectCredentials:
                // the users credentials were invalid
                [passwordAlert show];
                break;
            case CMUserAccountOperationFailedUnknownAccount:
                [existenceAlert show];
                // this account doesn't exist
                break;
        }
    }];
}
@end
