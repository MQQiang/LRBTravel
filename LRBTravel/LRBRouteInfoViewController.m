//
//  LRBRouteInfoViewController.m
//  LRBTravel
//
//  Created by mq on 14-10-9.
//  Copyright (c) 2014年 mqq.com. All rights reserved.
//

#import "LRBRouteInfoViewController.h"
#import "EScrollerView.h"
#import "LRBFillFormViewController.h"
#import "LRBLeaderInfoViewController.h"
#import "UIImage+ImageEffects.h"
#import "UIViewController+Blur.h"
#import "LRBJourneyViewController.h"
#import "LRBCostViewController.h"


@interface LRBRouteInfoViewController ()<EScrollerViewDelegate>{
    
    UIBarButtonItem *_favouriteButton;
    NSDictionary *_infoDic;
}

@end

@implementation LRBRouteInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _blurBlackView.alpha = 0;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 66, self.view.frame.size.width, 150)
                                                          ImageArray:[NSArray arrayWithObjects:@"1.jpg",@"2.jpg",@"3.jpg", nil]
                                                          TitleArray:nil];
    
    scroller.delegate=self;
    
    [self.view addSubview:scroller];
    
    self.title = @"路线详情";
    
    
    
    _favouriteButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favorite"]style:UIBarButtonItemStylePlain target:self action:@selector(addThisToMyFavourite:)];
//
    self.navigationItem.rightBarButtonItem = _favouriteButton;
    
    [self requestViewInfo];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidDisappear:(BOOL)animated{
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Button Method

-(void)EScrollerViewDidClicked:(NSUInteger)index{
    
    
}
- (IBAction)presentPathInfo:(id)sender {
    LRBJourneyViewController *vc = [[LRBJourneyViewController alloc] init];
    
    vc.info =_infoDic[@"short_intro"];
    
    [self loadSubView:vc];
}

- (IBAction)presentArrangeMemt:(id)sender {
    
}

- (IBAction)presentEquipmentRequire:(id)sender {
    
}

- (IBAction)presentCostInfo:(id)sender {
    LRBCostViewController *vc = [[LRBCostViewController alloc] init];
    vc.info =_infoDic[@"charge_announcement"];
    [self loadSubView:vc];
    
}

- (IBAction)presentNotice:(id)sender {
    
}
- (IBAction)connectPhoneNumber:(id)sender {
    
    [LRBUtil makePhoneCall:@"13656678405"];
}

- (IBAction)enrollForJourney:(id)sender {
    //Tuotuo
    LRBFillFormViewController *fillFormVC=[[LRBFillFormViewController alloc]init];
    fillFormVC.routeInfo=self.routeInfo;
    [self.navigationController pushViewController:fillFormVC animated:nil];
}

- (IBAction)presentLeaderInfo:(id)sender {
    
    LRBLeaderinfoViewController * leaderInfoVC = [[LRBLeaderinfoViewController alloc] init];
    
    _blurBlackView.alpha = 0.7;
    leaderInfoVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewControllerWithBlur:leaderInfoVC blurRedius:10 tintColor:[UIColor clearColor] saturationDeltaFactor:0.5];
    
    _blurBlackView.alpha = 0;
    
////    leaderInfoVC.modalPresentationStyle = UIModalPresentationFormSheet;
////    
////    [self presentViewController:leaderInfoVC animated:YES completion:^(){
////       
////        leaderInfoVC.view.backgroundColor = [UIColor clearColor];
////        
////    }];
//    
////    leaderInfoVC.view.backgroundColor = [UIColor clearColor];
////    
////    [leaderInfoVC.bgImageView setImage:[LRBUtil fullScreenShots]];
////    
//
//
//    
//    leaderInfoVC.modalPresentationStyle = UIModalPresentationFormSheet;
//    
//        [self presentViewController:leaderInfoVC animated:YES completion:^(){
//    
////            leaderInfoVC.view.superview.backgroundColor = [UIColor clearColor];
//    
//        }];
//    
    
}
-(void)loadSubView:(UIViewController *)vc{
    
    
    _blurBlackView.alpha = 0.7;
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewControllerWithBlur:vc blurRedius:10 tintColor:[UIColor clearColor] saturationDeltaFactor:0.5];
    
    _blurBlackView.alpha = 0;
    
}

#pragma mark - selector
-(void)addThisToMyFavourite:(id)sender{
    
    _favouriteButton.image = [UIImage imageNamed:@"favorite"];
}

-(void)requestViewInfo{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    
    NSDictionary *parameters = @{@"type":@"getPath",@"id":[NSNumber numberWithUnsignedInteger:_journeyId ]};
    [manager GET:[kHTTPServerAddress stringByAppendingString:@"php/api/PathApi.php"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self refreshView:responseObject];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];

    
}
-(void)refreshView:(NSDictionary *)dic{
    
    _infoDic = dic[@"paths"];
    
    _locationLabel.text = dic[@"paths"][@"address"];
    _datanumLabel.text = dic[@"paths"][@"day"];
    NSMutableString *dataString = [NSMutableString stringWithString: @"出发日期："];
    
   _titileLabel.text = [dataString stringByAppendingString: [dic[@"paths"][@"start_time"] substringToIndex:10]];
    
}
@end
