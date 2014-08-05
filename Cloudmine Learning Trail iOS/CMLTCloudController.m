//
//  CMLTCloudController.m
//  Cloudmine Learning Trail iOS
//
//  Created by Charles Burnett on 7/18/14.
//  Copyright (c) 2014 CloudMine. All rights reserved.
//

#import "CMLTCloudController.h"
#import "CMLTHighScoreViewController.h"

@implementation CMLTCloudController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
    CMStore *store = [CMStore defaultStore];
    [store allObjectsOfClass:[CMLTCloud class]
           additionalOptions:nil
                    callback:^(CMObjectFetchResponse *response) {
                        if (response.objects.count > 0) {
                            for (CMLTCloud * cloud in response.objects) {
                                if ([cloud.cmid isEqualToString:@"bluecloud"]) {
                                    _blueCloud = cloud;
                                }
                                if ([cloud.cmid isEqualToString:@"redcloud"]) {
                                    _redCloud = cloud;
                                }
                            }
                        }
                        else
                        {
                            _redCloud = [[CMLTCloud alloc] init];
                            _blueCloud = [[CMLTCloud alloc] init];
                            _redCloud.cmid = @"redcloud";
                            _blueCloud.cmid = @"bluecloud";
                        }
                        _blueCloud.clicks = _user.blue;
                        _redCloud.clicks = _user.red;
                        
                        [_redCloudLabel setText:[NSString stringWithFormat:@"Clicks: %ld", _user.red]];
                        [_blueCloudLabel setText:[NSString stringWithFormat:@"Clicks: %ld", _user.blue]];
                        [_totalCloudLabel setText:[NSString stringWithFormat:@"Total Clicks: %ld", _user.clicks]];
                    }];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    if (!_user) {
        CMLTLoginViewController *login = [self.storyboard instantiateViewControllerWithIdentifier:@"CMLTLoginViewController"];
        login.delegate = self;
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
        [self presentViewController:nav animated:NO completion:nil];
        return;
    }
}

- (void)controller:(CMLTLoginViewController *)controller didLoginWithUser:(CMLTUser *)user;
{
    self.user = user;
    [self dismissViewControllerAnimated:YES completion:^{
        
        if (_user.name.length == 0) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Pick a Nickname"
                                                             message:@"Enter you nickname"
                                                            delegate:self
                                                   cancelButtonTitle:@"Done"
                                                   otherButtonTitles: nil];
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alert show];
        }
        
    }];
    
}

/*
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didPressBlueCloud:(id)sender {
    _blueCloud.clicks++;
    
    [_blueCloudLabel setText:[NSString stringWithFormat:@"Clicks: %ld", _blueCloud.clicks]];
    [_totalCloudLabel setText:[NSString stringWithFormat:@"Total Clicks: %ld", _blueCloud.clicks + _redCloud.clicks]];
    
}

- (IBAction)didPressRedCloud:(id)sender {
    _redCloud.clicks++;
    
    [_redCloudLabel setText:[NSString stringWithFormat:@"Clicks: %ld", _redCloud.clicks]];
    [_totalCloudLabel setText:[NSString stringWithFormat:@"Total Clicks: %ld", _blueCloud.clicks + _redCloud.clicks]];
}

- (IBAction)didPressLogout:(id)sender {
    [[CMStore defaultStore].user logoutWithCallback:^(CMUserAccountResult resultCode, NSArray *messages) {

        if (CMUserAccountLogoutSucceeded) {
                    // success! the user is logged out
            CMLTLoginViewController *login = [self.storyboard instantiateViewControllerWithIdentifier:@"CMLTLoginViewController"];
            login.delegate = self;
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
            [self presentViewController:nav animated:YES completion:nil];
        }

    }];
}

- (IBAction)didPressHighScore:(id)sender {
    _user.red = _redCloud.clicks;
    _user.blue = _blueCloud.clicks;
    _user.clicks = _redCloud.clicks + _blueCloud.clicks;

    
    [_blueCloud save:^(CMObjectUploadResponse *response) {
        NSLog(@"Saved, %@", response);
    }];
    [_redCloud save:^(CMObjectUploadResponse *response) {
        NSLog(@"Saved, %@", response);
    }];
    [_user save:^(CMUserAccountResult resultCode, NSArray *messages){
        NSLog(@"Saved User %@", messages);
        
        CMLTHighScoreViewController *highScore = [self.storyboard instantiateViewControllerWithIdentifier:@"CMLTHighScoreViewController"];
        [self.navigationController pushViewController:highScore animated:YES];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSString *name = [alertView textFieldAtIndex:0].text;
        _user.name = name;
        NSLog(@"In app Del: %@", name);
    }
}

@end
