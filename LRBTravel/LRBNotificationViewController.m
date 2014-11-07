//
//  LRBNotificationViewController.m
//  LRBTravel
//
//  Created by mq on 14-10-9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBNotificationViewController.h"
#import "LRBNotificationDetailViewController.h"

@interface LRBNotificationViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation LRBNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    LRBNotificationDetailViewController *detailVC = [[LRBNotificationDetailViewController alloc] init];
    
    [self presentViewController:detailVC animated:YES completion:^(){}];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
