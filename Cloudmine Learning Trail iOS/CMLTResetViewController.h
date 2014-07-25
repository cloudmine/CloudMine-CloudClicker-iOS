//
//  CMLTResetViewController.h
//  Cloudmine Learning Trail iOS
//
//  Created by Charles Burnett on 7/25/14.
//  Copyright (c) 2014 CloudMine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMLTResetViewController : UIViewController <UIAlertViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *resetTextField;
- (IBAction)didPressSubmit:(id)sender;

@end
