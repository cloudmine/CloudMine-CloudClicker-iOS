//
//  CMLTHighScoreViewController.m
//  Cloudmine Learning Trail iOS
//
//  Created by Charles Burnett on 7/21/14.
//  Copyright (c) 2014 CloudMine. All rights reserved.
//

#import "CMLTHighScoreViewController.h"
#import <Cloudmine/CloudMine.h>
#import "CMScore.h"
@interface CMLTHighScoreViewController ()

@end

@implementation CMLTHighScoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    CMStore *store = [CMStore defaultStore];
    
    __block NSMutableArray * objectArray = [[NSMutableArray alloc] init];
    [store allObjectsWithOptions:nil
                        callback:^(CMObjectFetchResponse *response) {
                            NSLog(@"Objects: %@", response.objects);
                            objectArray = [NSMutableArray arrayWithArray:response.objects];
                            
                            NSString *highUser;
                            NSString *highBlueUser;
                            NSString *highRedUser;

                            int highscore = 0;
                            int highredscore = 0;
                            int highbluescore = 0;
                            
                            for (CMScore *score in objectArray) {
                                if (highscore<score.totalCloudScore) {
                                    highscore = score.totalCloudScore;
                                    highUser = score.username;
                                }
                                if (highredscore<score.redCloudScore) {
                                    highredscore = score.redCloudScore;
                                    highRedUser = score.username;
                                }
                                if (highbluescore<score.blueCloudScore) {
                                    highbluescore = score.blueCloudScore;
                                    highBlueUser = score.username;
                                }
                            }                            
                            NSLog(@"red: %d, blue: %d total: %d",highredscore,highbluescore,highscore);
                            [_RedScoreLabel setText:[NSString stringWithFormat:@"Red Cloud: %d - %@", highredscore, highRedUser]];
                            [_blueScoreLabel setText:[NSString stringWithFormat:@"Blue Cloud: %d - %@", highbluescore, highBlueUser]];
                            [_totalScoreLabel setText:[NSString stringWithFormat:@"Total Clicks: %d - %@", highscore, highUser]];
                        }
     ];
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

@end
