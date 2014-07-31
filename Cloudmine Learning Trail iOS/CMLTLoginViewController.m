//
//  CMLTViewController.m
//  Cloudmine Learning Trail iOS
//
//  Created by Charles Burnett on 7/17/14.
//  Copyright (c) 2014 CloudMine. All rights reserved.
//

#import "CMLTLoginViewController.h"
#import "CloudMine.h"
#import "CMLTCloudController.h"

@interface CMLTLoginViewController ()

@end

@implementation CMLTLoginViewController

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
    _user = [[CMLTUser alloc] initWithEmail:[_EmailTextField text] andPassword:[_PasswordTextField text]];
    UIAlertView * passwordAlert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Invalid Credentials" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    UIAlertView * existenceAlert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"An account with those credentials does not exist" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    UIAlertView * defaultAlert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"An Error occured in the login process." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];

    // You can use "anotherUser" here in the same way!
    [_user loginWithCallback:^(CMUserAccountResult resultCode, NSArray *messages) {
        switch(resultCode) {
            case CMUserAccountLoginSucceeded:
                // success! the user now has a session token
                [self initializePush];
                [self finishLogin];
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
    _user = [[CMLTUser alloc] init];

    [_user loginWithSocialNetwork:CMSocialNetworkFacebook viewController:self params:nil callback:^(CMUserAccountResult resultCode, NSArray *messages) {
        
        if (resultCode == CMUserAccountSocialLoginErrorOccurred) {
            return;
        }
        
        NSLog(@"user.token: %@", _user.token);

        if (resultCode == CMUserAccountLoginSucceeded) {
            //Logged in!
            [self initializePush];
            [self finishLogin];
        } else {
            //Look up and deal with error
            NSLog(@"Message? %@", messages);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
    
}

- (IBAction)googleLogin:(id)sender {
    _user = [[CMLTUser alloc] init];
    [_user loginWithSocialNetwork:@"google" viewController:self params:@{@"scope":@"openid"} callback:^(CMUserAccountResult resultCode, NSArray *messages) {
        NSLog(@"resultCode: %d", resultCode);
        
        if (resultCode == CMUserAccountLoginSucceeded) {
            //Logged in!
            [self initializePush];
            [self finishLogin];
        } else {
            //Look up and deal with error
            NSLog(@"Message? %@", messages);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
}

- (void)finishLogin;
{
    [CMStore defaultStore].user = _user;
    
    if ([self.delegate respondsToSelector:@selector(controller:didLoginWithUser:)]) {
        [self.delegate controller:self didLoginWithUser:_user];
    }
}


@end
