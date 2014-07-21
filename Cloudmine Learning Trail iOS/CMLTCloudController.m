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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _cloudScore = [[CMScore alloc] init];
    _cloudScore.blueCloudScore = 0;
    _cloudScore.redCloudScore = 0;
    _cloudScore.totalCloudScore = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"highScoreSegue"]){
        CMLTHighScoreViewController *controller = (CMLTHighScoreViewController *)segue.destinationViewController;
        controller.objectId = _cloudScore.objectId;
    }
}

- (IBAction)didPressBlueCloud:(id)sender {
    _cloudScore.blueCloudScore++;
    _cloudScore.totalCloudScore++;

    [_blueCloudLabel setText:[NSString stringWithFormat:@"Clicks: %d", _cloudScore.blueCloudScore]];
    [_totalCloudLabel setText:[NSString stringWithFormat:@"Total Clicks: %d", _cloudScore.totalCloudScore]];
    
    [_cloudScore save:^(CMObjectUploadResponse *response) {
        NSLog(@"Status: %@", [response.uploadStatuses objectForKey:_cloudScore.objectId]);
    }];
}

- (IBAction)didPressRedCloud:(id)sender {
    _cloudScore.redCloudScore++;
    _cloudScore.totalCloudScore++;
    [_redCloudLabel setText:[NSString stringWithFormat:@"Clicks: %d", _cloudScore.redCloudScore]];
    [_totalCloudLabel setText:[NSString stringWithFormat:@"Total Clicks: %d", _cloudScore.totalCloudScore]];
    
    [_cloudScore save:^(CMObjectUploadResponse *response) {
        NSLog(@"Status: %@", [response.uploadStatuses objectForKey:_cloudScore.objectId]);
    }];
}

@end
