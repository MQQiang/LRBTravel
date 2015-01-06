//
//  LRBNoticeViewController.m
//  
//
//  Created by mq on 15/1/6.
//
//

#import "LRBNoticeViewController.h"

#import "LRBNotificationDetailViewController.h"
#import "LRBUserInfo.h"
#import "LRBNotificationCellTableViewCell.h"

@interface LRBNoticeViewController()<UITableViewDataSource,UITableViewDelegate>
@property NSMutableArray *messageArray;
@end

@implementation LRBNoticeViewController




- (void)viewDidLoad {
    
    [super viewDidLoad];
    _messageArray = [[NSMutableArray alloc] init];
    
    [self requestMessageWithIndex:[NSNumber numberWithInteger: _tabBar.selectedSegmentIndex]];
    
    [_tabBar addTarget:self action:@selector(tabBarTap:) forControlEvents:UIControlEventValueChanged];
    
    
    [_noticeTableView registerNib:[UINib nibWithNibName:@"LRBNotificationCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"LRBNotificationCellTableViewCell"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tabBarTap:(UISegmentedControl *)sender{
    
    
    [self requestMessageWithIndex:[NSNumber numberWithInteger: sender.selectedSegmentIndex]];
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LRBNotificationCellTableViewCell *cell = (LRBNotificationCellTableViewCell *)[_noticeTableView  dequeueReusableCellWithIdentifier:@"LRBNotificationCellTableViewCell"];
    [cell setupLabelWithDic:nil];
    
    return  cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_messageArray count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    LRBNotificationDetailViewController *detailVC = [[LRBNotificationDetailViewController alloc] init];
    
    [self presentViewController:detailVC animated:YES completion:^(){}];
    
}
-(void)requestMessageWithIndex:(NSNumber *)index{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"type":@"getMessageList",@"user_id":[LRBUserInfo shareUserInfo].userId,@"message_type":index};
       manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self refreshView:responseObject];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSLog(@"Error: %@", error);
        
    }];
    
}
-(void)refreshView:(NSDictionary *)sender{
    
    if([[sender objectForKey:@"status"] isEqualToNumber:@1]){
        
        [_messageArray addObjectsFromArray:[sender objectForKey:@"message"]];
        
        [_noticeTableView reloadData];
    }
    
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
