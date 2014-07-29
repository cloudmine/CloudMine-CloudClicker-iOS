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
                            
                            int highscore = 0;
                            int highredscore = 0;
                            int highbluescore = 0;
                            
                            for (CMScore *score in objectArray) {
                                if (highscore<score.totalCloudScore) {
                                    highscore = score.totalCloudScore;
                                }
                                if (highredscore<score.redCloudScore) {
                                    highredscore = score.redCloudScore;
                                }
                                if (highbluescore<score.blueCloudScore) {
                                    highbluescore = score.blueCloudScore;
                                }
                            }
                            
                            NSLog(@"red: %d, blue: %d total: %d",highredscore,highbluescore,highscore);
                            [self updateScoresWithRedScore:highredscore blueScore:highbluescore andTotalScore:highscore];
                            
                        }
     ];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void) updateScoresWithRedScore:(int)red blueScore: (int) blue andTotalScore:(int)total{
    [_RedScoreLabel setText:[NSString stringWithFormat:@"Red Cloud: %d", red]];
    [_blueScoreLabel setText:[NSString stringWithFormat:@"Blue Cloud: %d", blue]];
    [_totalScoreLabel setText:[NSString stringWithFormat:@"Total Clicks: %d", total]];

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
