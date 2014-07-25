//
//  CMLTViewController.h
//  Cloudmine Learning Trail iOS
//
//  Created by Charles Burnett on 7/17/14.
//  Copyright (c) 2014 CloudMine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cloudmine.h"
@interface CMLTViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *EmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;
@property (strong, nonatomic) CMUser *user;
- (IBAction)login:(id)sender;
- (IBAction)facebookLogin:(id)sender;
- (IBAction)googleLogin:(id)sender;
@end
