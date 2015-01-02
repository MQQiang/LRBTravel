//
//  LRBLoginViewController.m
//  LRBTravel
//
//  Created by mq on 14-10-9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBLoginViewController.h"
#import "LRBUtil.h"
#import "REFrostedViewController.h"
#import "LRBIndexViewController.h"
#import "LRBSliderMenuViewController.h"
#import "LRBNavigationController.h"
#import "LRBRegisterViewController.h"
#import "LRBUserInfo.h"
#import "PrefixHeader.pch"
@interface LRBLoginViewController ()

@end

@implementation LRBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [LRBUtil drawCircleImage:_headImage];
    
    self.view.backgroundColor = UIColorFromRGB(0x009EE5);
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapppGestureRecognized:)]];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerMethod:)];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)login:(id)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"type":@"login",@"name":@"fpc",@"password":@"123456"};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([[dic objectForKey:@"status"] isEqual:@1]){
            
                    [self userLoginSuccess];
            [[LRBUserInfo shareUserInfo] setupUserInfo:[dic objectForKey:@"user"]];
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            [LRBUtil requestImagePrefix];
        }
        else{
            
            [[[UIAlertView alloc] initWithTitle:@"登入失败" message:@"检查用户名和密码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }

        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
    
}

- (IBAction)registerApp:(id)sender {
    
    [self registerMethod:sender];
}

- (IBAction)register:(id)sender {
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

-(void)registerMethod:(id)sender{
    
    LRBRegisterViewController *vc = [[LRBRegisterViewController alloc] init];
    
    if (self.navigationController) {
        
            [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        
        UINavigationController  *navC = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:navC animated:YES completion:nil];
        
        
    }


}


#pragma mark 
-(void)tapppGestureRecognized:(id)sender{
    [_password resignFirstResponder];
    [_userName resignFirstResponder];
    
}

@end
