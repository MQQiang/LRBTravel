//
//  LRBShareAppViewController.m
//  LRBTravel
//
//  Created by mq on 14/11/9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBShareAppViewController.h"
#import "UMSocial.h"
@interface LRBShareAppViewController ()

@end

@implementation LRBShareAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分享旅人帮";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)shareWeibo:(id)sender {
    

    
    
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"我正在使用旅人帮，你也来试试吧" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }];
}

- (IBAction)shareFriendCircle:(id)sender {
    
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://www.tripbong.com/backcall_tx.php";
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"旅人帮";
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"我在使用旅人帮，你也来试试吧" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }];
    
}

- (IBAction)shareWeiFriend:(id)sender {
    
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://baidu.com";
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"旅人帮";
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"我在使用旅人帮，你也来试试吧" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }];
    

}

- (IBAction)shareTecentWeibo:(id)sender {
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToTencent] content:@"正在使用旅人帮，你也来试试吧" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }];
    
}

- (IBAction)shareQQZone:(id)sender {
    
     [UMSocialData defaultData].extConfig.qzoneData.title = @"旅人帮";
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:@"我正在使用旅人帮，你也来试试吧" image:[UIImage imageNamed:@"APP_logo"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }];
}
@end
