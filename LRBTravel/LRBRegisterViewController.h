//
//  LRBRegisterViewController.h
//  LRBTravel
//
//  Created by mq on 14/12/1.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRBRegisterViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *ensurePasswordTextField;
- (IBAction)exitKeyBoard:(id)sender;
- (IBAction)regiest:(id)sender;

@end
