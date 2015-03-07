//
//  LRBPhotoBrowserViewController.m
//  LRBTravel
//
//  Created by Macintosh on 15-2-17.
//  Copyright (c) 2015年 mqq.com. All rights reserved.
//

#import "LRBPhotoBrowserViewController.h"
#import "LRBUserInfo.h"
#import "LRBEditCommentViewController.h"
#import "LRBCommentListViewController.h"
#import "LRBShareAppViewController.h"
#import "LRBShareToThirdPartyViewController.h"
#import "UIViewController+Blur.h"


@interface LRBPhotoBrowserViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView_sharePic;
@property (weak, nonatomic) IBOutlet UIButton *buttom_like;
@property (weak, nonatomic) IBOutlet UILabel *lable_description;
@property (weak, nonatomic) IBOutlet UILabel *lable_comment;
@property (weak, nonatomic) IBOutlet UILabel *lable_like;
@property (weak, nonatomic) IBOutlet UILabel *lable_time;
- (IBAction)like:(id)sender;
- (IBAction)editComment:(id)sender;
- (IBAction)viewComment:(id)sender;

- (IBAction)shareThis:(id)sender;

@property(nonatomic,strong)UIView *blurBgView;

@end

@implementation LRBPhotoBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=[self.shareData objectForKey:@"share_title"] ;
    
    self.imageView_sharePic.image=self.imageShared;
    self.lable_comment.text=[self.shareData objectForKey:@"collect_num"];
    //121.40.173.195/lvrenbang/php/api/ShareApi.php?type=getShareById&id=1&user_id=1
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSDictionary *parameters = @{@"type":@"getShareById",@"id":self.shareId,@"user_id":[LRBUserInfo shareUserInfo].userId};
    NSDictionary *parameters = @{@"type":@"getShareById",@"id":self.shareId,@"user_id":@"1"};
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    
    
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/ShareApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

        self.shareData= (NSDictionary *)responseObject;
        
        NSLog(@"JSON: %@", responseObject);
        
        if([[self.shareData objectForKey:@"status"] isEqual:@1]){
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [self changeData];
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
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"edit"]style:UIBarButtonItemStylePlain target:self action:@selector(editComment:)];
    
    
    
    [self.navigationController setNavigationBarHidden:NO];

    [self.navigationController.navigationBar setBackgroundColor:[UIColor blackColor]];
    
    
    _blurBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height)];
    
    _blurBgView.backgroundColor = [UIColor blackColor];
    
    _blurBgView.alpha = 0;
    
    [self.view addSubview:_blurBgView];
    // Do any additional setup after loading the view from its nib.
}
-(void)changeData
{
    self.lable_comment.text=[[self.shareData objectForKey:@"share"] objectForKey:@"reply_count"];
    self.lable_like.text=[[self.shareData objectForKey:@"share"] objectForKey:@"favor_count"];
    self.title=[[self.shareData objectForKey:@"share"] objectForKey:@"title"];
    self.lable_description.text=[[self.shareData objectForKey:@"share"] objectForKey:@"content"];
    self.lable_time.text=[[self.shareData objectForKey:@"share"] objectForKey:@"create_time"];
    if ([[[self.shareData objectForKey:@"share"] objectForKey:@"self_favor"] isEqual:@"1"]) {
        self.buttom_like.selected=YES;
    }
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
//
    _blurBgView.alpha = 0;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)shareThis:(id)sender{
    
    LRBShareToThirdPartyViewController *vc = [[LRBShareToThirdPartyViewController alloc] init];
    
    vc.image = self.imageShared;
    
    _blurBgView.alpha = 0.3;
    
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewControllerWithBlur:vc blurRedius:20 tintColor:[UIColor clearColor] saturationDeltaFactor:0.5];
    
//    [self.navigationController pushViewController:vc animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)like:(id)sender {
    
    if (self.buttom_like.selected==YES) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您已经赞过" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
        
        
        return;
    }
    [self.buttom_like setEnabled:false];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",nil];
    
    NSDictionary *parameters = @{@"type":@"addShareFavor",@"share_id":@"1",@"user_id":[LRBUserInfo shareUserInfo].userId};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.buttom_like setImage:[UIImage imageNamed:@"like_r"] forState:UIControlStateNormal];
        //
        NSLog(@"%@",responseObject);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"点赞成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [self.buttom_like setEnabled:false];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (IBAction)viewComment:(id)sender {
    
    LRBCommentListViewController *pushView=[[LRBCommentListViewController alloc] init];
    pushView.shareData=self.shareData;
    pushView.shareId=self.shareId;
    pushView.imageShared=self.imageShared;
    
    
    
    [self.navigationController pushViewController:pushView animated:YES];
    
    
}
- (IBAction)editComment:(id)sender {
    
    LRBEditCommentViewController *pushView=[[LRBEditCommentViewController alloc] init];
    pushView.shareId=self.shareId;
    [self.navigationController pushViewController:pushView animated:YES];
    
    
}
@end
