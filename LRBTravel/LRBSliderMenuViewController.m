//
//  LRBSliderMenuViewController.m
//  
//
//  Created by mq on 14/11/7.
//
//
#import "REFrostedViewController.h"
#import "LRBSliderMenuViewController.h"
#import "LRBUtil.h"
#import "LRBPictureShareViewController.h"
#import "LRBIndexViewController.h"
#import "LRBNavigationController.h"
#import "LRBShareAppViewController.h"
#import "LRBFeedbackViewController.h"
#import "LRBAboutUsViewController.h"
#import "LRBSetupViewController.h"
#import "LRBPersonInfoViewController.h"
#import "LRBUserInfo.h"
#import "UIImageView+Circle.h"
#import "LRBEditPersonInfoViewController.h"

@interface LRBSliderMenuViewController ()
{
    NSArray* _menuNameArray ;
    NSInteger _nowViewTag;
}



@end

@implementation LRBSliderMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _nowViewTag = 0;
    
     _menuNameArray = @[@"精品路线",@"旅图分享",@"分享APP",@"意见反馈",@"关于旅人帮",@"设置"];
    
    _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 
    [_headImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapppGestureRecognized:)]];
    _userMessageCountLabel.hidden = YES;
//    [self RequestUserMessageCount];


    _nameLabel.text = [LRBUserInfo shareUserInfo].nickName;

    
    [_headImageView drawCircleImage];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
//    [self RequestUserMessageCount];
    if ([LRBUserInfo shareUserInfo].profile) {
        
        [_headImageView setImageWithURL:[NSURL URLWithString:[[LRBUtil imageProfix] stringByAppendingString:[LRBUserInfo shareUserInfo].profile ]]];
        
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_menuTableView dequeueReusableCellWithIdentifier:@"MenuTableViewCellId"];
    if(cell == nil){
        
        cell= [[UITableViewCell alloc] init];
        
       
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];
//        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    cell.textLabel.text = _menuNameArray[indexPath.row];
    
    return cell;

}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath   {
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _menuNameArray.count;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [_menuTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    do {
        if (_nowViewTag == indexPath.row) {
            break;
        }
        
       
        
        UIViewController * contentVc;
        
        switch (indexPath.row) {
            case 0:
                contentVc = [[LRBIndexViewController alloc] init];
                
                
                break;
            case 1:
                contentVc = [[LRBPictureShareViewController alloc] init];
                break;
            case 2:
                contentVc = [[LRBShareAppViewController alloc] init];
                
                break;
            case 3:
                contentVc = [[LRBFeedbackViewController alloc] init];
                break;
            case 4:
                contentVc = [[LRBAboutUsViewController alloc] init];
                break;
            case 5:
                contentVc = [[LRBEditPersonInfoViewController alloc] init];
                break;
            default:
                break;
        }
        
         LRBNavigationController *navVc = [[LRBNavigationController alloc] initWithRootViewController:contentVc];
        self.frostedViewController.contentViewController = navVc;
        _nowViewTag = indexPath.row;
        
    } while (0);
    
    
    
    [self.frostedViewController hideMenuViewController];
   
}
#pragma mark Gesture
-(void)tapppGestureRecognized:(id)sender{
    
    LRBPersonInfoViewController *personVc = [[LRBPersonInfoViewController alloc] init];
    
    UINavigationController* navVC = [[UINavigationController alloc]initWithRootViewController:personVc];
    //[self presentViewController:navVC animated:YES completion:^{}];
    
    [self presentViewController:navVC animated:YES completion:^(){
#warning 什么东西0.0
        [self.frostedViewController hideMenuViewController];
    }];
    
}

-(void)beginRequestWithExtensionContext:(NSExtensionContext *)context{
    
    
}

-(void)RequestUserMessageCount{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"type":@"getMessageCount",@"id":[LRBUserInfo shareUserInfo].userId};
    
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/UserApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self refreshView:responseObject];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];

}
-(void)refreshView:(NSDictionary *)sender{
    
    if([sender objectForKey:@"status"])
    {
        [self setMessageCountWith:[sender objectForKey:@"count"]];
    }
    else{
        
    }
    
}
-(void)dealloc
{
    NSLog(@"aa");
}
-(void)setMessageCountWith:(NSNumber *)number{
    
    if ([number isEqualToNumber:@0]) {
        
        _userMessageCountLabel.hidden = YES;
        
    }
    else {
        _userMessageCountLabel.hidden = NO;
        _userMessageCountLabel.text = [number stringValue];
    }
}

@end
