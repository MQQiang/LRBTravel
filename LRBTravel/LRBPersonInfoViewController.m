//
//  LRBPersonInfoViewController.m
//  LRBTravel
//
//  Created by mq on 14-10-9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBPersonInfoViewController.h"
#import "LRBUserInfo.h"
#include "UIImageView+Circle.h"
#import "LRBPathTabelViewCell.h"
#import "LRBEditPersonInfoViewController.h"
#import "LRBNoticeViewController.h"
@interface LRBPersonInfoViewController (){

    NSMutableArray * _collectionArray;
    NSMutableArray * _myOrderArray;
    NSMutableArray * _myShareArray;
    NSMutableArray *_dataArray;
    
    
}

@end

@implementation LRBPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",_profileImageView);
     [_profileImageView setImageWithURL:[NSURL URLWithString:[[LRBUtil imageProfix] stringByAppendingString:[LRBUserInfo shareUserInfo].profile ]]];
    
    
    
      [_profileImageView drawCircleImage];
    
    _nameLabel.text = [LRBUserInfo shareUserInfo].nickName;
    
    _infoTabelView.delegate = self;
    _infoTabelView.dataSource = self;
    _infoTabelView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.navigationController setToolbarHidden:YES];
    [self.navigationController setNavigationBarHidden:YES];
    
    [_segmentedControl addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];  //添加委托方法
    
    [_infoTabelView registerNib:[UINib nibWithNibName:@"LRBPathTabelViewCell" bundle:nil] forCellReuseIdentifier:@"PathTableViewId"];
    [self initData];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController setToolbarHidden:YES];
    [self.navigationController setNavigationBarHidden:YES];
    
}
-(void)initData{
    _myOrderArray = [[NSMutableArray alloc] init];
    _myShareArray = [[NSMutableArray alloc] init];
    _collectionArray = [[NSMutableArray alloc] init];
    
    _dataArray = [NSMutableArray arrayWithObjects:_myOrderArray,_collectionArray,_myOrderArray, nil];
}
// [segmentedControl setEnabled:NO forSegmentAtIndex:4];//设置指定索引选项不可选

// BOOL enableFlag = [segmentedControl isEnabledForSegmentAtIndex:4];//判断指定索引选项是否可选
//具体委托方法实例

-(void)segmentAction:(UISegmentedControl *)Seg{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    
    [_infoTabelView reloadData];
    
    switch (Index) {
        case 1:
            [self requestOrderData];
            break;
        case 2:
            [self requestPathData];
            break;
        case 3:
            [self requestShareData];
        default:
            break;
    }
    
    
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_segmentedControl.selectedSegmentIndex != 0) {
        
      
        return [[_dataArray objectAtIndex:_segmentedControl.selectedSegmentIndex-1] count];
    }
    
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_segmentedControl.selectedSegmentIndex !=0) {
        
        LRBPathTabelViewCell *cell = [_infoTabelView dequeueReusableCellWithIdentifier:@"PathTableViewId"];
        [cell setupTabelViewCellWith:[_dataArray[_segmentedControl.selectedSegmentIndex-1]objectAtIndex:indexPath.row] Type:_segmentedControl.selectedSegmentIndex];
        
        return cell;
        
    }

    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSString *text = @"";
    
    switch (indexPath.row) {
        case 0:
            text = [NSString stringWithFormat:@"姓名:%@",[LRBUserInfo shareUserInfo].nickName];
            break;
        case 1:
             text = [NSString stringWithFormat:@"邮箱:%@",[LRBUserInfo shareUserInfo].email ];
            break;
        case 2:
             text = [NSString stringWithFormat:@"电话:%@",[LRBUserInfo shareUserInfo].phoneNumber];
        default:
            break;
    }
    cell.textLabel.text = text;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_segmentedControl.selectedSegmentIndex) {
        
        return 80.0f;
    }
    
    
    return 60.0f;
}

- (IBAction)backtoForward:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)showNotification:(id)sender{
    
    LRBNoticeViewController *vc = [[LRBNoticeViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
-(void)requestOrderData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",nil];
    
    NSDictionary *parameters = @{@"type":@"getParticipated",@"user_id":[LRBUserInfo shareUserInfo].userId};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        [self refreshView:responseObject];
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        [_myOrderArray removeAllObjects];
        [_myOrderArray addObjectsFromArray:dic[@"path"]];
        
          [_infoTabelView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];

    
}
-(void)requestPathData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",nil];
    
    NSDictionary *parameters = @{@"type":@"getCollectedPath",@"user_id":[LRBUserInfo shareUserInfo].userId};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        //        [self refreshView:responseObject];
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        [_collectionArray removeAllObjects];
        [_collectionArray addObjectsFromArray:dic[@"path"]];
          [_infoTabelView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];}
-(void)requestShareData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",nil];
    
    NSDictionary *parameters = @{@"type":@"getMyShare",@"user_id":[LRBUserInfo shareUserInfo].userId};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        //        [self refreshView:responseObject];
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        [_myShareArray removeAllObjects];
        [_myShareArray addObjectsFromArray:dic[@"share"]];
        
        [_infoTabelView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
}

- (IBAction)editInfo:(id)sender {
    
    
    
    LRBEditPersonInfoViewController *newView=[[LRBEditPersonInfoViewController alloc] init];
    //
    //    [self presentViewController:newView animated:YES completion:^(){
    //
    //       // [self.frostedViewController hideMenuViewController];
    //    }];
    //
    
    [self.navigationController pushViewController:newView animated:YES];
    
    
}
@end
