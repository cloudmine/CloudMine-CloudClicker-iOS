//
//  CMLTViewController.h
//  Cloudmine Learning Trail iOS
//
//  Created by Charles Burnett on 7/17/14.
//  Copyright (c) 2014 CloudMine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cloudmine.h"
#import "CMLTUser.h"

@protocol CMLTLoginDelegate;

@interface CMLTLoginViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) id<CMLTLoginDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *EmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;
@property (strong, nonatomic) CMLTUser *user;

- (IBAction)login:(id)sender;
- (IBAction)facebookLogin:(id)sender;
- (IBAction)googleLogin:(id)sender;

@end


@protocol CMLTLoginDelegate <NSObject>
@optional

- (void)controller:(CMLTLoginViewController *)controller didLoginWithUser:(CMLTUser *)user;

@end