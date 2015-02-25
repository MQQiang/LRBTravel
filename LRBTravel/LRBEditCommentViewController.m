//
//  LRBEditCommentViewController.m
//  LRBTravel
//
//  Created by Macintosh on 15-2-24.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "LRBEditCommentViewController.h"
#import "LRBUserInfo.h"
@interface LRBEditCommentViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView_comment;

@end

@implementation LRBEditCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"请输入评论";
    UIBarButtonItem *buttom_edit=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    
    [self.navigationItem setRightBarButtonItem:buttom_edit];
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


-(void)done
{
    //121.40.173.195/lvrenbang/php/api/ShareApi.php?type=postReply&user_id=1&share_id=1&title=香格里拉旅行&content=这次旅行很不错，很喜欢

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  
    if (self.textView_comment.text==nil ) {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"请输入内容" message:@"评论内容不得为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    NSDictionary *parameters = @{@"type":@"postReply",@"share_id":@"1",@"user_id":[LRBUserInfo shareUserInfo].userId,@"title":@"香格里拉旅行",@"content":self.textView_comment.text};
    
    
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/ShareApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // [self refreshView:responseObject];
        NSDictionary* returnInfo =responseObject;
        if([returnInfo objectForKey:@"status"]){
           [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"Error: %@", error);
        
    }];
    
    
    
    
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

@end
