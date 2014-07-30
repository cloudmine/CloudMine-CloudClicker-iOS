//
//  CMLTCloudController.h
//  Cloudmine Learning Trail iOS
//
//  Created by Charles Burnett on 7/18/14.
//  Copyright (c) 2014 CloudMine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMLTCloud.h"
#import "CMLTUser.h"

@interface CMLTCloudController : UIViewController <UIAlertViewDelegate>
- (IBAction)didPressBlueCloud:(id)sender;
- (IBAction)didPressRedCloud:(id)sender;
- (IBAction)didPressLogout:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *blueCloudLabel;
@property (weak, nonatomic) IBOutlet UILabel *redCloudLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalCloudLabel;

@property (strong, nonatomic) CMLTCloud * redCloud;
@property (strong, nonatomic) CMLTCloud * blueCloud;

@property (strong, nonatomic) CMLTUser *user;
@property (strong, nonatomic) NSString *userString;
@property int blueCount;
@property int redCount;
@property int totalCount;

@end
