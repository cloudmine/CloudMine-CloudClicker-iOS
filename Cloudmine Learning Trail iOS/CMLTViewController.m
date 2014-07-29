//
//  CMLTViewController.m
//  Cloudmine Learning Trail iOS
//
//  Created by Charles Burnett on 7/17/14.
//  Copyright (c) 2014 CloudMine. All rights reserved.
//

#import "CMLTViewController.h"
#import "CloudMine.h"
#import "CMLTCloudController.h"

@interface CMLTViewController ()

@end

@implementation CMLTViewController

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
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
        [_PasswordTextField becomeFirstResponder];
    }
    return YES;
}

- (void) initializePush
{
    [CMStore defaultStore].user = _user;
    [[CMStore defaultStore] registerForPushNotifications:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)
                                                callback:^(CMDeviceTokenResult result) {
                                                    if (result == CMDeviceTokenUploadSuccess || result == CMDeviceTokenUpdated) {
                                                        NSLog(@"Registered successfully!");
                                                    } else {
                                                        NSLog(@"Uh oh, something happened: %d", result);
                                                    }
                                                }];
}

- (IBAction)login:(id)sender {
    _user = [[CMUser alloc] initWithEmail:[_EmailTextField text] andPassword:[_PasswordTextField text]];
    UIAlertView * passwordAlert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Invalid Credentials" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    UIAlertView * existenceAlert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"An account with those credentials does not exist" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    UIAlertView * defaultAlert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"An Error occured in the login process." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];

    // You can use "anotherUser" here in the same way!
    [_user loginWithCallback:^(CMUserAccountResult resultCode, NSArray *messages) {
        switch(resultCode) {
            case CMUserAccountLoginSucceeded:
                // success! the user now has a session token
                [self initializePush];
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
            default:
                [defaultAlert show];
        }
    }];
}

- (IBAction)facebookLogin:(id)sender {
    _user = [[CMUser alloc] init];
    
    [_user loginWithSocialNetwork:CMSocialNetworkFacebook viewController:self params:nil callback:^(CMUserAccountResult resultCode, NSArray *messages) {
        NSLog(@"resultCode: %d", resultCode);

        if (resultCode == CMUserAccountLoginSucceeded) {
            //Logged in!
            [self initializePush];
            [self dismissViewControllerAnimated:YES completion:nil];
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        } else {
            //Look up and deal with error
            NSLog(@"Message? %@", messages);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
    
}

- (IBAction)googleLogin:(id)sender {
    _user = [[CMUser alloc] init];
    [_user loginWithSocialNetwork:@"google" viewController:self params:@{@"scope":@"openid"} callback:^(CMUserAccountResult resultCode, NSArray *messages) {
        NSLog(@"resultCode: %d", resultCode);
        
        if (resultCode == CMUserAccountLoginSucceeded) {
            //Logged in!
            [self initializePush];
            [self dismissViewControllerAnimated:YES completion:nil];
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        } else {
            //Look up and deal with error
            NSLog(@"Message? %@", messages);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"loginSegue"])
    {
        // Get reference to the destination view controller
        CMLTCloudController *cc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        cc.user = _user.username;
    }
}

- (IBAction)unwindToThisViewController:(UIStoryboardSegue *)unwindSegue
{
    
}

@end
