//
//  LRBSetupViewController.m
//  LRBTravel
//
//  Created by mq on 14/11/9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBSetupViewController.h"

@interface LRBSetupViewController ()

@end

@implementation LRBSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView    {

    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    int  ret[2]= {4,2};
    
    return ret[section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [[UITableViewCell alloc] init];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray * array = @[@"个人资料",@"系统设置"];
    
    return array[section];
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
