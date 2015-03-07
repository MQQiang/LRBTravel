//
//  LRBCommentListViewController.m
//  LRBTravel
//
//  Created by Macintosh on 15-2-24.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "LRBCommentListViewController.h"
#import "LRBCommentListTableViewCell.h"
@interface LRBCommentListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView_sharedPic;





@end

@implementation LRBCommentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//     self.title=[[self.shareData objectForKey:@"share"] objectForKey:@"title"];
    self.title = @"评论列表";

    [self.tableView_comments registerNib:[UINib nibWithNibName:@"LRBCommentListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LRBCommentListTableViewCell"];
    [self loadData];
    
    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillAppear:(BOOL)animated
{
    //
    
    UINavigationBar* navigationBar=self.navigationController.navigationBar;
    //navigationBar.tintColor=[UIColor blackColor];
    navigationBar.barTintColor =[UIColor blackColor] ;
    //[self.navigationController.navigationBar setBackgroundColor:[UIColor redColor]];
    //self.navigationController.navigationBar.translucent = NO;
    
    
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nvb"] forBarMetrics:UIBarMetricsDefault];
    
    // self.navigationController.navigationBar.alpha=1;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.0/255.0 green:128.0/255.0 blue:1 alpha:1];
}


-(void)loadData
{
    
    self.imageView_sharedPic.image=self.imageShared;
    
    

    NSDictionary *parameters = @{@"type":@"getReply",@"share_id":self.shareId,@"limit":@"1000",@"offset":@"0"};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    
    //121.40.173.195/lvrenbang/php/api/ShareApi.php?type=getReply&share_id=2&limit=5&offset=0
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/ShareApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic= (NSDictionary *)responseObject;
        
        
        NSLog(@"JSON: %@", responseObject);
        
        if([[dic objectForKey:@"status"] isEqual:@1]){
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            self.data_Comments= [dic objectForKey:@"reply"];

            [self.tableView_comments reloadData];
            
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - tableViewDelegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
        return 1;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LRBCommentListTableViewCell *cell=[LRBCommentListTableViewCell initWithTableView:self.tableView_comments cellData:[self.data_Comments objectAtIndex:indexPath.row]];
    
    CGRect frame=cell.label_comment.frame;
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.data_Comments==nil) {
        return 0;
        
    }
    else  return [self.data_Comments count];
    


}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [[self.data_Comments objectAtIndex:indexPath.row] objectForKey:@"content"];
    CGSize constraint = CGSizeMake(270, 20000.0f);
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
  
    
    return 85+size.height;

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
