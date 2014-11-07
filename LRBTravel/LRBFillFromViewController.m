//
//  LRBFillFromViewController.m
//  LRBTravel
//
//  Created by mq on 14/10/25.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBFillFromViewController.h"

@interface LRBFillFromViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * _headTitleArray;
}

@end

@implementation LRBFillFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _formTableView.dataSource = self;
    _formTableView.delegate  = self;
    
   _headTitleArray = @[@"订单信息" , @"联系人信息"];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _headTitleArray[section];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20.0f;
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
