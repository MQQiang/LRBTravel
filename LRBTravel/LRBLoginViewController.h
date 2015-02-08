//
//  LRBLoginViewController.h
//  LRBTravel
//
//  Created by mq on 14-10-9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
@interface LRBLoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
- (IBAction)login:(id)sender;
- (IBAction)registerApp:(id)sender;

-(IBAction)loginInWithQQ:(id)sender;
- (IBAction)loginWithWeiChat:(id)sender;
- (IBAction)loginWifhWeiBo:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
- (IBAction)forgetPassword:(id)sender;
@property(nonatomic,assign)BOOL NOAutoLogin;
@end
