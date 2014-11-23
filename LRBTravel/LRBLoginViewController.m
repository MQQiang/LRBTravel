//
//  LRBLoginViewController.m
//  LRBTravel
//
//  Created by mq on 14-10-9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//
#import "AFNetworking.h"
#import "LRBLoginViewController.h"
#import "LRBUtil.h"
#import "REFrostedViewController.h"
#import "LRBIndexViewController.h"
#import "LRBSliderMenuViewController.h"
#import "LRBNavigationController.h"

@interface LRBLoginViewController ()

@end

@implementation LRBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [LRBUtil drawCircleImage:_headImage];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapppGestureRecognized:)]];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)login:(id)sender {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"type":@"login",@"name":@"fpc",@"password":@"123456"};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        
        [self userLoginSuccess];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
}

-(void)loginInWithQQ:(id)sender
{
    
}

- (IBAction)loginWithWeiChat:(id)sender {
}

- (IBAction)loginWifhWeiBo:(id)sender {
}



-(void)userLoginSuccess
{
    
    
    LRBIndexViewController *indexViewController = [[LRBIndexViewController alloc] init];
    
    LRBNavigationController *navController = [[LRBNavigationController alloc] initWithRootViewController:indexViewController];
    
    LRBSliderMenuViewController   *sliderMenuVc = [[LRBSliderMenuViewController alloc] init];
    
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navController menuViewController:sliderMenuVc];
    
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    frostedViewController.liveBlur = YES;
//    frostedViewController.delegate = self;
   
//    self.view.window.rootViewController = frostedViewController;
    

    
    [self presentViewController:frostedViewController animated:YES completion:^(){}];
//    [self.navigationController presentViewController:frostedViewController animated:YES completion:nil];
    
}

-(void)userLoginFailed
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)forgetPassword:(id)sender {
    
    
}

#pragma mark 
-(void)tapppGestureRecognized:(id)sender{
    [_password resignFirstResponder];
    [_userName resignFirstResponder];
    
}

@end
