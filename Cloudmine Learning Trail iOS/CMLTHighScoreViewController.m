//
//  CMLTHighScoreViewController.m
//  Cloudmine Learning Trail iOS
//
//  Created by Charles Burnett on 7/21/14.
//  Copyright (c) 2014 CloudMine. All rights reserved.
//

#import "CMLTHighScoreViewController.h"
#import <Cloudmine/CloudMine.h>
#import "CMLTUser.h"

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
    [super viewWillAppear:animated];
    
    [CMLTUser allUsersWithCallback:^(NSArray *users, NSDictionary *errors) {
                            NSLog(@"Users: %@", users);
                            NSArray * objectArray = [NSArray arrayWithArray:users];
                            
                            NSString *highUser;
                            NSString *highBlueUser;
                            NSString *highRedUser;

                            NSInteger highscore = 0;
                            NSInteger highredscore = 0;
                            NSInteger highbluescore = 0;
                            
                            for (CMLTUser *user in objectArray) {
                                if (highscore< user.clicks) {
                                    highscore = user.clicks;
                                    highUser = user.name;
                                }
                                if (highredscore<user.red) {
                                    highredscore = user.red;
                                    highRedUser = user.name;
                                }
                                if (highbluescore<user.blue) {
                                    highbluescore = user.blue;
                                    highBlueUser = user.name;
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
