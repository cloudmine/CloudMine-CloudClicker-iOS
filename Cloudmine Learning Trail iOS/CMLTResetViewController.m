//
//  CMLTResetViewController.m
//  Cloudmine Learning Trail iOS
//
//  Created by Charles Burnett on 7/25/14.
//  Copyright (c) 2014 CloudMine. All rights reserved.
//

#import "CMLTResetViewController.h"
#import "Cloudmine.h"
@interface CMLTResetViewController ()

@end

@implementation CMLTResetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)didPressSubmit:(id)sender {
    CMUser *user = [[CMUser alloc] initWithEmail:_resetTextField.text andPassword:@""];
    
    [user resetForgottenPasswordWithCallback:^(CMUserAccountResult resultCode, NSArray *messages) {
        switch(resultCode) {
            case CMUserAccountPasswordResetEmailSent:
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Recovery Email Sent" message:@"An email has been sent to the specified address" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
                [alert show];
                break;

            }
            default:
            {
                UIAlertView *failedAlert = [[UIAlertView alloc]initWithTitle:@"Reset Failed" message:@"An error occured. Please check your email address and try again." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
                [failedAlert show];
                break;
            }
        }
    }];
}
@end
