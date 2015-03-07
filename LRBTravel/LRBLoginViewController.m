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
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"

@interface LRBLoginViewController ()<UMSocialUIDelegate>

@end

@implementation LRBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [LRBUtil drawCircleImage:_headImage];
    
    self.view.backgroundColor = UIColorFromRGB(0x009EE5);
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapppGestureRecognized:)]];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerMethod:)];
    // Do any additional setup after loading the view from its nib.
    _userName.text = @"fpc";
    _password.text =@"123456";
}

-(void)viewDidAppear:(BOOL)animated{
    
//    if (!_NOAutoLogin) {
//        
//        NSString *userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_name"];
//        NSString *password = [NSUserDefaults standardUserDefaults] valueForKey:@"password"
//        
//    }
    
    NSString *userName =[[NSUserDefaults standardUserDefaults] valueForKey:@"UserName"];
    NSString *password = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserPassword"];
    
    if (userName&&![userName isEqualToString:@""]&&password&&![password isEqualToString:@""]) {
        
        
        self.userName.text = userName;
        self.password.text = password;
        
        [self login:nil];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)login:(id)sender {
    
    
    if ([_userName.text isEqualToString:@""]) {
        
        [[[UIAlertView alloc] initWithTitle:@"填写用户名" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show ];
        
        return;
    }
    
    
    if([_password.text isEqualToString:@""]){
        
            [[[UIAlertView alloc] initWithTitle:@"填写密码" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show ];
        return;
        
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"type":@"login",@"name":_userName.text,@"password":_password.text};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        if([[dic objectForKey:@"status"] isEqual:@1]){
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
                    [self userLoginSuccess];
            

            
            [[LRBUserInfo shareUserInfo] setupUserInfo:[dic objectForKey:@"user"]];
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
          
            
            [LRBUtil requestImagePrefix];
        }
        else{
            
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            [[[UIAlertView alloc] initWithTitle:@"登入失败" message:@"检查用户名和密码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }

        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
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
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"response is %@",response);
        
        [self setQQOpenIddic:response.data];
        
    });
    //设置回调对象
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
}

- (IBAction)loginWithWeiChat:(id)sender {
    
    
    [[[UIAlertView alloc] initWithTitle:@"对不起" message:@"暂时不支持微信登入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
    
    return;
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"response is %@",response);
    });
    //设置回调对象
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
}

- (IBAction)loginWifhWeiBo:(id)sender {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            [self setweiboOpenIdNickName:snsAccount.userName openId:snsAccount.usid];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
            [self login:nil];
        }
        
    });
    //设置回调对象
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
    
}



-(void)userLoginSuccess
{
    [[NSUserDefaults standardUserDefaults] setValue:self.userName.text forKey:@"UserName"];
    [[NSUserDefaults standardUserDefaults] setValue:self.password.text forKey:@"UserPassword"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    LRBIndexViewController *indexViewController = [[LRBIndexViewController alloc] init];
    
    LRBNavigationController *navController = [[LRBNavigationController alloc] initWithRootViewController:indexViewController];
    
    LRBSliderMenuViewController   *sliderMenuVc = [[LRBSliderMenuViewController alloc] init];
    
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navController menuViewController:sliderMenuVc];
    
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    frostedViewController.liveBlur = YES;
//    frostedViewController.delegate = self;
   
//    self.view.window.rootViewController = frostedViewController;
    
    [[NSUserDefaults standardUserDefaults] setValue:@0 forKey:@"login"];
    
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


-(void)setQQOpenIddic:(NSDictionary *)dic{
    
    
    //http://121.40.173.195//lvrenbang/php/api/UserApi.php?type=setQQOpenId&open_id=654321&nick_name=werwerew
    
    NSDictionary *dic2 = dic[@"qq"];
    NSString *nickName =dic2[@"username"];
    
    NSString *openId =  dic2[@"usid"];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",nil];
    
    NSDictionary *parameters = @{@"type":@"setQQOpenId",@"open_id":openId,@"nick_name":nickName};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         NSDictionary *dic = (NSDictionary *)responseObject;
        
        if([[dic objectForKey:@"status"] isEqual:@1]){
            
            [self userLoginSuccess];
            [[LRBUserInfo shareUserInfo] setupUserInfo:[dic objectForKey:@"user"]];
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            [LRBUtil requestImagePrefix];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];

    
}


-(void)setweiboOpenIdNickName:(NSString *)name openId:(NSString *)openId{
    
    
    //http://121.40.173.195//lvrenbang/php/api/UserApi.php?type=
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",nil];
    
    NSDictionary *parameters = @{@"type":@"setWeiboOpenId",@"open_id":openId,@"nick_name":name};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        if([[dic objectForKey:@"status"] isEqual:@1]){
            
            [self userLoginSuccess];
            [[LRBUserInfo shareUserInfo] setupUserInfo:[dic objectForKey:@"user"]];
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            [LRBUtil requestImagePrefix];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
    
}

/**
 自定义关闭授权页面事件
 
 @param navigationCtroller 关闭当前页面的navigationCtroller对象
 
 */
-(BOOL)closeOauthWebViewController:(UINavigationController *)navigationCtroller socialControllerService:(UMSocialControllerService *)socialControllerService{
    
    
    //qq
    
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsInformation is %@",response.data);
    }];
    
    
    // weibo
    
    //获取accestoken以及新浪用户信息，得到的数据在回调Block对象形参respone的data属性
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsInformation is %@",response.data);
    }];
    
    
    // weixin
    
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsInformation is %@",response.data);
    }];
    
    
    return true;
    
}

/**
 关闭当前页面之后
 
 @param fromViewControllerType 关闭的页面类型
 
 */
-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType{
    
}

/**
 各个页面执行授权完成、分享完成、或者评论完成时的回调函数
 
 @param response 返回`UMSocialResponseEntity`对象，`UMSocialResponseEntity`里面的viewControllerType属性可以获得页面类型
 */
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
    
}

/**
 点击分享列表页面，之后的回调方法，你可以通过判断不同的分享平台，来设置分享内容。
 例如：
 
 -(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
 {
 if (platformName == UMShareToSina) {
 socialData.shareText = @"分享到新浪微博的文字内容";
 }
 else{
 socialData.shareText = @"分享到其他平台的文字内容";
 }
 }
 
 @param platformName 点击分享平台
 
 @prarm socialData   分享内容
 */
-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData{
    
}


/**
 配置点击分享列表后是否弹出分享内容编辑页面，再弹出分享，默认需要弹出分享编辑页面
 
 @result 设置是否需要弹出分享内容编辑页面，默认需要
 
 */
-(BOOL)isDirectShareInIconActionSheet{
    return  true;
}

@end
