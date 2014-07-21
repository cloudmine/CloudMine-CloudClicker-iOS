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

- (void)viewDidLoad
{
    [super viewDidLoad];
    CMStore *store = [CMStore defaultStore];

    NSArray *keys = [NSArray arrayWithObject:_objectId];
    
    [store objectsWithKeys:keys
         additionalOptions:nil
                  callback:^(CMObjectFetchResponse *response) {
                      NSLog(@"Objects: %@", response.objects);
                      CMScore *score = [response.objects objectAtIndex:0];
                      [self updateScoresWithRedScore:score.redCloudScore blueScore:score.blueCloudScore andTotalScore:score.totalCloudScore];
                  }
     ];
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
