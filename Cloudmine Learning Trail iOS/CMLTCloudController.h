//
//  CMLTCloudController.h
//  Cloudmine Learning Trail iOS
//
//  Created by Charles Burnett on 7/18/14.
//  Copyright (c) 2014 CloudMine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMScore.h"
@interface CMLTCloudController : UIViewController
- (IBAction)didPressBlueCloud:(id)sender;
- (IBAction)didPressRedCloud:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *blueCloudLabel;
@property (weak, nonatomic) IBOutlet UILabel *redCloudLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalCloudLabel;

@property (strong, nonatomic)  CMScore *cloudScore;

@property int blueCount;
@property int redCount;
@property int totalCount;

@end
