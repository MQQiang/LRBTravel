//
//  LRBFillFromViewController.m
//  LRBTravel
//
//  Created by mq on 14/10/25.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBFillFromViewController.h"
#import "LRBFillFormTableViewCell.h"

#define kFillFormTableViewCellID @"FillFormTableViewCellID"


@interface LRBFillFromViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * _headTitleArray;
    NSArray *_contentTitleArray;
}

@end

@implementation LRBFillFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"报名";
    _formTableView.dataSource = self;
    _formTableView.delegate  = self;
    [_formTableView registerNib:[UINib nibWithNibName:@"LRBFillFormTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kFillFormTableViewCellID];
   _headTitleArray = @[@"订单信息" , @"联系人信息"];
    
    _formTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    _contentTitleArray = @[@[@"出发日期：",@"报名人数：",@"价格："],@[@"姓名：",@"电话：",@"邮箱："]];
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
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LRBFillFormTableViewCell * cell = [_formTableView dequeueReusableCellWithIdentifier:kFillFormTableViewCellID];
    cell.titleLabel.text = [[_contentTitleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

-(void)signUp{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"type":@"join"};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/PathApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        [self refreshView:responseObject];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];

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
