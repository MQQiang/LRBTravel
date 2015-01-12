//
//  LRBNotificationDetailViewController.m
//  LRBTravel
//
//  Created by mq on 14-10-9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBNotificationDetailViewController.h"

@interface LRBNotificationDetailViewController ()

@end

@implementation LRBNotificationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestNotificationInfo];
    self.title = @"通知消息";
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
-(void)setupViewWithDic:(NSDictionary *)dic{
    _notificationTitleLabel.text = dic [@""];
    
}
-(void)requestNotificationInfo{
    
    

    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",nil];
    
    NSDictionary *parameters = @{@"type":@"getMessage",@"id":[NSNumber numberWithUnsignedInteger:_notificationId]};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self refreshView:[[responseObject objectForKey:@"message"] objectAtIndex:0] ];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];

    
}
-(void)refreshView:(NSDictionary *)dic{
    
    
    
    _notificationTitleLabel.text = dic [@"m_title"];
    _notificationTextView.text = dic [@"m_content"];
    
}


@end
