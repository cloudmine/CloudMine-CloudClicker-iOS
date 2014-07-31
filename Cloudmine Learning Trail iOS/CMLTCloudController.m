//
//  CMLTCloudController.m
//  Cloudmine Learning Trail iOS
//
//  Created by Charles Burnett on 7/18/14.
//  Copyright (c) 2014 CloudMine. All rights reserved.
//

#import "CMLTCloudController.h"
#import "CMLTHighScoreViewController.h"

@interface CMLTCloudController ()

@end

@implementation CMLTCloudController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.navigationBar.hidden = YES;

    
    CMStore *store = [CMStore defaultStore];
    [store allObjectsOfClass:[CMLTCloud class]
           additionalOptions:nil
                    callback:^(CMObjectFetchResponse *response) {
                        if (response.objects.count > 0) {
                            for (CMLTCloud * cloud in response.objects) {
                                NSLog(@"object %@", cloud);
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
                            NSLog(@"In init");
                            _redCloud = [[CMLTCloud alloc] init];
                            _blueCloud = [[CMLTCloud alloc] init];
                            _redCloud.cmid = @"redcloud";
                            _blueCloud.cmid = @"bluecloud";
                        }
                        _blueCloud.clicks = _user.blue;
                        _redCloud.clicks = _user.red;
                        NSLog(@"blue: %d red: %d userblue %d userred %d", _blueCloud.clicks, _redCloud.clicks, _user.blue,  _user.red);
                        
                        [_redCloudLabel setText:[NSString stringWithFormat:@"Clicks: %d", _user.red]];
                        [_blueCloudLabel setText:[NSString stringWithFormat:@"Clicks: %d", _user.blue]];
                        [_totalCloudLabel setText:[NSString stringWithFormat:@"Total Clicks: %d", _user.clicks]];
                    }];
    
}


-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (_user.name.length == 0) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Pick a Nickname" message:@"Enter you nickname" delegate:self cancelButtonTitle:@"Done" otherButtonTitles: nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSLog(@"in bluecloud: blue: %d red: %d userblue %d userred %d", _blueCloud.clicks, _redCloud.clicks, _user.blue,  _user.red);
    _blueCloud.clicks++;
    
    [_blueCloudLabel setText:[NSString stringWithFormat:@"Clicks: %d", _blueCloud.clicks]];
    [_totalCloudLabel setText:[NSString stringWithFormat:@"Total Clicks: %d", _blueCloud.clicks + _redCloud.clicks]];
    
}

- (IBAction)didPressRedCloud:(id)sender {
    NSLog(@"In redcloud: blue: %d red: %d userblue %d userred %d", _blueCloud.clicks, _redCloud.clicks, _user.blue,  _user.red);

    _redCloud.clicks++;
    
    [_redCloudLabel setText:[NSString stringWithFormat:@"Clicks: %d", _redCloud.clicks]];
    [_totalCloudLabel setText:[NSString stringWithFormat:@"Total Clicks: %d", _blueCloud.clicks + _redCloud.clicks]];
}

- (IBAction)didPressLogout:(id)sender {
    [[CMStore defaultStore].user logoutWithCallback:^(CMUserAccountResult resultCode, NSArray *messages) {
        NSLog(@"result code, %d messages %@", resultCode, messages);

        if (CMUserAccountLogoutSucceeded) {
                    // success! the user is logged out
            [self performSegueWithIdentifier:@"logoutSegue" sender:self];
        }

    }];
}

- (IBAction)didPressHighScore:(id)sender {
        NSLog(@"Username %@ email %@", _user.username, _user.class);
    _user.red = _redCloud.clicks;
    _user.blue = _blueCloud.clicks;
    _user.clicks = _redCloud.clicks + _blueCloud.clicks;
    NSLog(@"In DPHS: blue: %d red: %d userblue %d userred %d", _blueCloud.clicks, _redCloud.clicks, _user.blue,  _user.red);

    
    [_blueCloud save:^(CMObjectUploadResponse *response) {
        NSLog(@"Saved, %@", response);
    }];
    [_redCloud save:^(CMObjectUploadResponse *response) {
        NSLog(@"Saved, %@", response);
    }];
    [_user save:^(CMUserAccountResult resultCode, NSArray *messages){
        NSLog(@"Saved User %@", messages);
        [self performSegueWithIdentifier:@"highScoreSegue" sender:self];
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
